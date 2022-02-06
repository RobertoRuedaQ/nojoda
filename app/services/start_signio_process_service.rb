class StartSignioProcessService

  def self.for(legal_match_id, pdf, pdf_promissory_note=nil)
    new(legal_match_id, pdf, pdf_promissory_note).perform
  end

  def initialize(legal_match_id, pdf, pdf_promissory_note)
    @legal_match = LegalMatch.find(legal_match_id)
    @promissory_note_legal_match = LegalMatch.find_by(parent_id: @legal_match.id )
    @current_user = @legal_match.user
    @pdf = pdf
    @pdf_promissory_note = pdf_promissory_note
    @token = nil
    @id_transaction = nil
    @id_contract_document = nil
    @id_promissory_document = nil
    @id_student_signio = nil 
    @id_jointly_liable_signio = nil
    @id_legal_representative_signio = nil
    @id_zigma_representative_signio = nil
    @tag_coordinates = {}
    @add_signature_coordinates_student_response = nil
    @add_signature_coordinates_legal_representative_response = nil
    @add_signature_coordinates_jointly_liable_response = nil
    @add_signature_coordinates_zigma_representative_response = nil
    @send_to_sign_response = nil
    @comments = nil
  end


  def perform
    execute_the_process
  end

  # private
  
  def pdf_contract_file
    pdf = File.open('contracto.pdf', 'wb') do |file|
      file << @pdf
    end
    return pdf
  end

  def pdf_promissory_note_file
    pdf = File.open('pagare.pdf', 'wb') do |file|
      file << @pdf_promissory_note
    end
    return pdf
  end

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
  
  def information_signio_embolo
    embolo_information = {}
    embolo_information[:name] = @current_user.full_name
    embolo_information[:message] = "firma del documento #{@legal_match.legal_document.name} del estudiante #{@current_user.full_name}."
    embolo_information[:tags] = @current_user.application.first.funding_opportunity.name
    embolo_information[:cc] = ENV['EMAIL_FOR_SIGNED_CONTRACTS'] #Add variable to heroku
    embolo_information[:op_btnRechazo] = 1 #SIGNIO setting to allow the student to reject the document 
    embolo_information[:op_foto] = 'OB' #makes demandatory to take a photo when signing the doc.
    embolo_information[:op_certLegops] = 0 #don't add Legops certification to document
    embolo_information[:op_firmasProcesadas] = 1 #save historial of signatures procecess.
    return embolo_information
  end

  #creates the "embolo", it works as a folder that contain all the information of the signers and the documents
  def create_embolo(information_signio_embolo)
    embolo_data = information_signio_embolo
    target_params =  {
      nombre: embolo_data[:name],
      mensaje: embolo_data[:message],
      tags: embolo_data[:tags],
      cc: embolo_data[:cc],
      op_btnRechazo: embolo_data[:op_btnRechazo],
      op_foto: embolo_data[:op_foto],
      op_certLegops: embolo_data[:op_certLegops],
      op_firmasProcesadas: embolo_data[:op_firmasProcesadas]
    }
    begin
      response = RestClient::Request.execute(method: :post, url: "#{service_url}/transacciones/crear",
      :payload => target_params.to_json,
      headers: {:content_type => :json, :accept => :json, :authorization => "Bearer #{@token}"},
      :verify_ssl => true )
      formated_response = JSON.parse(response.body)
      case formated_response['codigo']
      when '00'
        @id_transaction = formated_response['id_transaccion']
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end

  #Load the pdf file to the embolo asigned to the process.
  def load_contract_file_and_signer
    metatags = {}
    
    if @tag_coordinates[:contract]['{{SigStamp:student:200,60}}'].any?
      metatags.merge( student: {})
      metatags[:student] = student_signer_data
    end
    if @tag_coordinates[:contract]['{{SigStamp:legal_representative:200,60}}'].any?
      metatags.merge( legal_representative: {})
      metatags[:legal_representative] = legal_representative_signer_data
    end
    if @tag_coordinates[:contract]['{{SigStamp:joint_liable:200,60}}'].any?
      metatags.merge( joint_liable: {})
      metatags[:joint_liable] = jointly_liable_signer_data
    end
    if @tag_coordinates[:contract]['{{SigStamp:zigma_legal_representative:200,60}}'].any?
      metatags.merge( zigma_legal_representative: {})
      metatags[:zigma_legal_representative] = zigma_representative_signer_data
    end

    begin
      response = RestClient::Request.execute(
        method: :post, 
        url: "#{service_url}/transacciones/cargar_documento",
        payload: {
          id_transaccion: @id_transaction,
          documento: File.open(pdf_contract_file),
          metatags: JSON.generate(metatags)
        },
        headers: {:content_type => 'multipart/form-data', :accept => :json, :authorization => "Bearer #{@token}" },
        :verify_ssl => true )
        formated_response = JSON.parse(response.body)
      case formated_response['codigo']
      when '00'
        puts 'File successfuly loaded'
        @id_contract_document = formated_response['id_documento']
        File.delete(pdf_contract_file) 
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end

  def load_promissory_note_file_and_signers
    metatags = {}
    if @tag_coordinates[:contract]['{{SigStamp:student:200,60}}'].any?
      metatags.merge(student: {})
      metatags[:student] = student_signer_data
    end
    if @tag_coordinates[:contract]['{{SigStamp:joint_liable:200,60}}'].any?
      metatags.merge(joint_liable: {})
      metatags[:joint_liable] = jointly_liable_signer_data
    end

    if @tag_coordinates[:contract]['{{SigStamp:tutor:200,60}}'].any?
      metatags.merge(tutor: {})
      metatags[:tutor] = tutor_signer_data
    end

    begin
      response = RestClient::Request.execute(method: :post, url: "#{service_url}/transacciones/cargar_documento",
      payload: {
        id_transaccion: @id_transaction,
        documento: File.open(pdf_promissory_note_file),
        metatags: JSON.generate(metatags)
      },
      headers: {:content_type => 'multipart/form-data', :accept => :json, :authorization => "Bearer #{@token}" },
      :verify_ssl => true )
      formated_response = JSON.parse(response.body)
      case formated_response['codigo']
      when '00'
        puts 'File successfuly loaded'
        @id_promissory_document = formated_response['id_documento']
        File.delete(pdf_promissory_note_file) 
      end
    rescue RestClient::ExceptionWithResponse => e
      puts e.response
    end
  end

  def student_signer_data
    {
    SigName: @current_user.full_name,
    SigIDType: @current_user.user_document_type_for_signio,
    SigID: @current_user.identification_number.to_s,
    SigEmail: @current_user.email,
    SigPhone: @current_user.contact_info.mobile.to_s,
    SigOrder: 1
  }
  end

  def jointly_liable_signer_data
    joint_liable = @current_user.reference.where(jointly_liable: true).first
    {
    SigName: joint_liable.name,
    SigIDType: joint_liable.reference_document_type_for_signio,
    SigID: joint_liable.identification_number.to_s,
    SigEmail: joint_liable.reference_email,
    SigPhone: joint_liable.mobile.to_s,
    SigOrder: 1
  }
  end

  def tutor_signer_data
    tutor = @current_user.reference.where(guardian_case: true).or(@current_user.reference.where(reference_case: 'guardian')).first
    {
    SigName: tutor.name,
    SigIDType: tutor.reference_document_type_for_signio,
    SigID: tutor.identification_number.to_s,
    SigEmail: tutor.reference_email,
    SigPhone: tutor.mobile.to_s,
    SigOrder: 1
  }
  end

  def legal_representative_signer_data
    {
    SigName: ENV['LEGAL_REPRESENTATIVE_NAME'],
    SigIDType: ENV['LEGAL_REPRESENTATIVE_IDENTIFICATION_TYPE'],
    SigID: ENV['LEGAL_REPRESENTATIVE_IDENTIFICATION_NUMBER'],
    SigEmail: ENV['LEGAL_REPRESENTATIVE_EMAIL'],
    SigPhone: ENV['LEGAL_REPRESENTATIVE_MOBILE'],
    SigOrder: 2,
    SigCmpy: ENV['LEGAL_REPRESENTATIVE_COMPANY_NAME'],
    SigCmpyID: ENV['LEGAL_REPRESENTATIVE_COMPANY_NIT'],
    SigCmpyIDType: 'NIT'
  }
  end

  def zigma_representative_signer_data
    {
    SigName: ENV['ZIGMA_REPRESENTATIVE_NAME'],
    SigIDType: ENV['ZIGMA_REPRESENTATIVE_IDENTIFICATION_TYPE'],
    SigID: ENV['ZIGMA_REPRESENTATIVE_IDENTIFICATION_NUMBER'],
    SigEmail: ENV['ZIGMA_REPRESENTATIVE_EMAIL'],
    SigPhone: ENV['ZIGMA_REPRESENTATIVE_MOBILE'],
    SigOrder: 2,
    SigCmpy: ENV['ZIGMA_REPRESENTATIVE_COMPANY_NAME'],
    SigCmpyID: ENV['ZIGMA_REPRESENTATIVE_COMPANY_NIT'],
    SigCmpyIDType: 'NIT'
  }
  end

  def send_to_sign
    begin
      target_params =  {
        id_transaccion: @id_transaction
        } 
      response = RestClient::Request.execute(method: :post, url: "#{service_url}/transacciones/distribuir",
                                            :payload => target_params.to_json,
                                            headers: {:content_type => :json, :accept => :json, :authorization => "Bearer #{@token}" },
                                            :verify_ssl => true )

      formated_response = JSON.parse(response.body)
      case formated_response['codigo']
      when '00'
        @send_to_sign_response = 'Success'
      end
    rescue RestClient::ExceptionWithResponse => e
      @send_to_sign_response = e.response
    end
  end

  def service_url
    return ENV['SIGNIO_API_URL']
  end

  def send_promissory_note_to_protection
    begin
      target_params =  {
          id_documento: @id_promissory_document,
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

  def create_signio_record
    SignioRecord.create(
          legal_match_id:@legal_match.id,
          promissory_note_legal_match_id: @promissory_note_legal_match.id,
          user_id: @current_user.id,
          id_transaction: @id_transaction,
          id_contract_document: @id_contract_document,
          id_promissory_document: @id_promissory_document,
          id_student_in_signio: @id_student_signio,
          id_jointly_liable_in_signio: @id_jointly_liable_signio,
          id_legal_representative_in_signio:@id_legal_representative_signio,
          id_zigma_representative_in_signio: @id_zigma_representative_signio,
          tag_coordinates: @tag_coordinates,
          add_signature_coordinates_student_response: @add_signature_coordinates_student_response,
          add_signature_coordinates_legal_representative_response: @add_signature_coordinates_legal_representative_response,
          add_signature_coordinates_jointly_liable_response: @add_signature_coordinates_jointly_liable_response,
          add_signature_coordinates_zigma_representative_response: @add_signature_coordinates_zigma_representative_response,
          send_to_sign_response: @send_to_sign_response,
          comments: @comments
        )
  end

  def execute_the_process
    begin
      if @legal_match.instance_of? LegalMatch
        @tag_coordinates[:contract] = FindSignaturesCoordinatesService.for(@legal_match.id, @pdf)
        @tag_coordinates[:promissory_note] = FindSignaturesCoordinatesService.for(@legal_match.id, @pdf_promissory_note) unless @pdf_promissory_note.nil?
        request_token
        create_embolo(information_signio_embolo)
        load_contract_file_and_signer
        load_promissory_note_file_and_signers unless @pdf_promissory_note.nil?
        send_promissory_note_to_protection unless @pdf_promissory_note.nil?
        send_to_sign
        create_signio_record
      end
    rescue Exception => e
      @comments = e
    end
    create_signio_record
  end

end