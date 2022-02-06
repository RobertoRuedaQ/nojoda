module Api::V1
  class SignioRecordsController < ApiController
    skip_before_action :verify_authenticity_token
    before_action :set_signio_record, only: [:update_legal_match_file, :delete_legal_match]

    def update_legal_match_file
      if @signio_record.present?
        legal_match = LegalMatch.find(@signio_record.legal_match_id)
        promissory_note_legal_match = LegalMatch.find_by(parent_id: legal_match.id )
        documents = params['Documentos']
        documents.each do |document|
          url = document['ruta']
          filename = File.basename(URI.parse(url).path)
          file = URI.open(url)
          if document['nombre'].include?('contracto')
            legal_match.scanned_document.attach(io: file, filename: filename, content_type: 'application/pdf')
          else
            promissory_note_legal_match.scanned_document.attach(io: file, filename: filename, content_type: 'application/pdf')
          end
        end
        legal_match.save
        promissory_note_legal_matchlegal_match.save unless promissory_note_legal_match.nil?
      end

      render json: {data: {response: 'Success'}}, status: 200
    end

    def delete_legal_match
    puts "lo que se recibe como params son #{params}"
      if @signio_record.present?
        legal_match = LegalMatch.find(@signio_record.legal_match_id)
        puts "el legal match id es #{legal_match.id}"
        legal_match_promissory = LegalMatch.find_by(parent_id: legal_match.id)
        puts "el legal match id del pagare es #{legal_match_promissory.id}"
        legal_match_promissory.destroy unless legal_match_promissory.nil?
        legal_match.destroy
      end
      render json: {data: {response: 'Success'}}, status: 200
    end

    private
    def set_signio_record
      @signio_record = SignioRecord.find_by(id_transaction: params[:id])
    end

  end
end