class ProtectPromissoryNoteService

  def self.for(signio_record_id)
    new(signio_record_id).perform
  end

  def initialize(signio_record_id)
    @signio_record = SignioRecord.find(signio_record_id)
    @token = nil
  end


  def perform
    execute_the_process
  end

  # private
  
  def request_token
    begin
      target_params =  {
          email: ENV['SIGNIO_EMAIL'],
          password: ENV['SIGNIO_ACCESS_KEY']
          } 
      response = RestClient::Request.execute(method: :post, url: "#{service_url}/token/crear",
                                            :payload => target_params.to_json,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => true )

      formated_response = JSON.parse(response.body)
      case formated_response['codigo']
      when '00'
        @token = formated_response['token']
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end

  def send_promissory_note_to_protection
    begin
      target_params =  {
          id_documento: @signio_record.id_promissory_document,
          protect: true
          } 
      response = RestClient::Request.execute(method: :post, url: "#{service_url}/documentos/proteger/",
                                            :payload => target_params.to_json,
                                            headers: {:content_type => :json, :accept => :json },
                                            :verify_ssl => true )

      formated_response = JSON.parse(response.body)
      case formated_response['codigo']
      when '00'
        puts 'success'
        @signio_record.update(promissory_document_protected: true)
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end

  def service_url
    return ENV['SIGNIO_API_URL']
  end


  def execute_the_process
    begin
      if @signio_record.instance_of? SignioRecord
        request_token
      end
    rescue Exception => e
      @comments = e
    end
    
  end

end