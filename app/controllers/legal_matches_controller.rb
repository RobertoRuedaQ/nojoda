class LegalMatchesController < ApplicationController
	include LumniOrigination
	def index
		@legal_match = LegalMatch.lumniStart(params,current_company,list: current_user.template('LegalMatch','legal_matches',current_user))
		legalMatchResult = @legal_match.lumniSave(params,current_user, list: current_user.template('LegalMatch','legal_matches',current_user))
		lumniClose(@legal_match,legalMatchResult, list: current_user.template('LegalMatch','legal_matches',current_user))
	end

	def new
		@legal_match = LegalMatch.lumniStart(params,current_company,list: current_user.template('LegalMatch','legal_matches',current_user))
		legalMatchResult = @legal_match.lumniSave(params,current_user, list: current_user.template('LegalMatch','legal_matches',current_user))
		lumniClose(@legal_match,legalMatchResult, list: current_user.template('LegalMatch','legal_matches',current_user))
	end

	def create
		@legal_match = LegalMatch.new()
		@legal_match.attributes = {
			answer: params['legalmatch']['answer'],
			user_id: params['legalmatch']['user_id'],
			validation_method: params['legalmatch']['validation_method'],
			validation: params['legalmatch']['validation'],
			body: params['legalmatch']['body'],
			legal_document_id: params['legalmatch']['legal_document_id']
		}
		@legal_match.save

		if params['legalmatch']['promissory_note_body'].present?
			@legal_match_promissory_note = LegalMatch.new()
			@legal_match_promissory_note.attributes = {
				answer: params['legalmatch']['answer'],
				user_id: params['legalmatch']['user_id'],
				validation_method: params['legalmatch']['validation_method'],
				validation: params['legalmatch']['validation'],
				body: params['legalmatch']['promissory_note_body'],
				legal_document_id: params['legalmatch']['promissory_note_legal_document_id'],
				parent_id: @legal_match.id
			}
			@legal_match_promissory_note.save
		end

		if !@legal_match.resource.nil? && !@legal_match.resource.selected?
			modeling_match = ModelingMatch.create({application_id: @legal_match.application_id,resource_type: 'FundingOption',resource_id: @legal_match.resource_id,status: 'selected'})
		end
		
		#in case is a contract, an amendment or promissory note should sent to sign the document externaly
		legal_document_type = @legal_match.legal_document.document_type
		if ['isa_contract_young', 'isa_contract', 'isa_contract_adult', 'amendment_young', 'amendment_adult', 'promissory_note'].include?(legal_document_type)
			pdf = create_pdf_document(@legal_match)
			if @legal_match_promissory_note.present?
				pdf_promissory_note = create_pdf_document(@legal_match_promissory_note)
				StartSignioProcessService.for(@legal_match.id, pdf, pdf_promissory_note)
			else
				StartSignioProcessService.for(@legal_match.id, pdf)
			end
		end

		if @legal_match.send_email
			if Rails.env == 'production'
				LegalEmailsDelyveryAsync.perform_async(current_user.id,@legal_match.id)
				if @legal_match_promissory_note.present?
					LegalEmailsDelyveryAsync.perform_async(current_user.id,@legal_match_promissory_note.id)
				end
			else
				CommunicationMailer.legal_document_mail(current_user.id,@legal_match.id).deliver
				if @legal_match_promissory_note.present?
					CommunicationMailer.legal_document_mail(current_user.id,@legal_match_promissory_note.id).deliver
				end
			end
			review_case = @legal_match.application.present? ? @legal_match.application.resource_type : nil
			case review_case
			when 'Isa'
				redirect_to edit_application_path(@legal_match.application)
			else
				originationResult = @legal_match.origination_legal_process( params,params[:legalmatch][:user_id])
				originationRedirect(originationResult,current_user.id)
				if originationResult.nil?
					lumniClose(@legal_match,legalMatchResult, list: current_user.template('LegalMatch','legal_matches',current_user))
				end
			end

		
		end

	end

	def edit
		@legal_match = LegalMatch.lumniStart(params,current_company,list: current_user.template('LegalMatch','legal_matches',current_user))
		legalMatchResult = @legal_match.lumniSave(params,current_user, list: current_user.template('LegalMatch','legal_matches',current_user))
		lumniClose(@legal_match,legalMatchResult, list: current_user.template('LegalMatch','legal_matches',current_user))
	end

	def update
		@legal_match = LegalMatch.lumniStart(params,current_company,list: current_user.template('LegalMatch','legal_matches',current_user))
		legalMatchResult = @legal_match.lumniSave(params,current_user, list: current_user.template('LegalMatch','legal_matches',current_user))
		lumniClose(@legal_match,legalMatchResult, list: current_user.template('LegalMatch','legal_matches',current_user))
	end
	def destroy
		@legal_match = LegalMatch.lumniStart(params,current_company,list: current_user.template('LegalMatch','legal_matches',current_user))
		legalMatchResult = @legal_match.lumniSave(params,current_user, list: current_user.template('LegalMatch','legal_matches',current_user))
		lumniClose(@legal_match,legalMatchResult, list: current_user.template('LegalMatch','legal_matches',current_user))
	end

	def preview
		@legal_document = LegalDocument.cached_find(params[:id])
	    respond_to do |format|
	      format.pdf do
	        render 	pdf: '/legal_matches/preview',
	        		layout: 'pdf.html',
	        		page_size: 'letter',
	        		margin:  {  top:               20,
	                            bottom:            20,
	                            left:              20,
	                            right:             20 }
	      end
	    end		
	end

	def download_pdf
		@legal_document = LegalDocument.cached_find(params[:id])

		pdf = WickedPdf.new.pdf_from_string(
		  render_to_string(
		  	inline: helpers.adjust_legal_language( current_user, @legal_document.body), 
		  	layout: 'pdf.html',
	        		page_size: 'letter',
	        		margin:  {  top:               20,
	                            bottom:            20,
	                            left:              20,
	                            right:             20 }
		))

		send_data pdf, filename: "#{@legal_document.name}.pdf"
	end

	def legal_document
	    respond_to do |format|
	      format.pdf do
	        render 	pdf: '/legal_matches/legal_document',
	        		layout: 'pdf.html',
	        		page_size: 'letter',
	        		margin:  {  top:               20,
	                            bottom:            20,
	                            left:              20,
	                            right:             20 }
	      end
	    end		
	end

	def create_pdf_document(legal_match)
		pdf = WickedPdf.new.pdf_from_string(
			render_to_string(
				inline: helpers.adjust_legal_language( current_user, legal_match.body), 
				layout: 'pdf.html',
				page_size: 'letter',
				margin:  {  top:               20,
				bottom:            20,
				left:              20,
				right:             20 }
				))
				
				save_path = Rails.root.join('pdfs', "#{legal_match.user.identification_number}_contract.pdf")
				File.open(save_path, 'wb') do |file|
					file << pdf
				end
		
		return pdf
	end


end
