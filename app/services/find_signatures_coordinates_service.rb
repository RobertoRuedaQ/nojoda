class FindSignaturesCoordinatesService

  def self.for(legal_match_id, pdf)
    new(legal_match_id, pdf).perform
  end

  def initialize(legal_match_id, pdf)
    @legal_match = LegalMatch.find(legal_match_id)
    @current_user = @legal_match.user
    @pdf = pdf
  end


  def perform
    if @legal_match.instance_of? LegalMatch
      find_student_signature_tag
    end
  end

  private
  
  def find_student_signature_tag
    pdf_file = StringIO.new(@pdf) #gem don't read the file itself, is necessary to transform into an StringIO object.
    reader = PDF::Reader::Turtletext.new(pdf_file) #read the file with the gem
    tags = ['{{SigStamp:student:200,60}}', '{{SigStamp:legal_representative:200,60}}', '{{SigStamp:zigma_legal_representative:200,60}}', '{{SigStamp:joint_liable:200,60}}', '{{SigStamp:tutor:200,60}}'] #declare the tags for seeking in the file.
    information = {} 
    number_of_pages = reader.reader.page_count
    tags.each do |tag|
       #start looking for each tag in the document page by page
      information["#{tag}"] = {}
      (1..number_of_pages).each do |n|
        puts "revisando la pagina #{n}"
        reader.content(n).each do |row|
          item = row.second #each row has 2 elements: the Y coordinate and an array with the formate [x coordinate, letter]
          if item.is_a? Array #check we are using the right info
            word = item.map{|coord_letter| coord_letter[1]}
            word_comparison = word.join
            if word_comparison.include?(tag)
              puts "#{word_comparison} hizo match"
              information["#{tag}"][:coord_y] =  row[0]
              information["#{tag}"][:coord_x] =  item.first[0] #item has the x coordinate information in the first element of the array.
              information["#{tag}"][:page] =  n
            end
          end
        end
      end
    end
    return information
  end

end