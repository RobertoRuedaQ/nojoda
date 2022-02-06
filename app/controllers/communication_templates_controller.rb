class CommunicationTemplatesController < ApplicationController
	helper LumniMailer

	def index
		@communication_template = CommunicationTemplate.lumniStart(params,current_company,list: communication_templates_fields)
		communicationTemplateResult = @communication_template.lumniSave(params,current_user,list: communication_templates_fields)
		lumniClose(@communication_template,communicationTemplateResult,list: communication_templates_fields)
	end

	def new
		@communication_template = CommunicationTemplate.lumniStart(params,current_company,list: communication_templates_fields)
		@communication_template.company = current_company
		communicationTemplateResult = @communication_template.lumniSave(params,current_user,list: communication_templates_fields)
		lumniClose(@communication_template,communicationTemplateResult,list: communication_templates_fields)
	end

	def create
		@communication_template = CommunicationTemplate.lumniStart(params,current_company,list: communication_templates_fields)
		communicationTemplateResult = @communication_template.lumniSave(params,current_user,list: communication_templates_fields)
		lumniClose(@communication_template,communicationTemplateResult,list: communication_templates_fields)
	end

	def edit
		@communication_template = CommunicationTemplate.lumniStart(params,current_company,list: communication_templates_fields)
		communicationTemplateResult = @communication_template.lumniSave(params,current_user,list: communication_templates_fields)
		lumniClose(@communication_template,communicationTemplateResult,list: communication_templates_fields)
	end

	def update
		@communication_template = CommunicationTemplate.lumniStart(params,current_company,list: communication_templates_fields)
		communicationTemplateResult = @communication_template.lumniSave(params,current_user,list: communication_templates_fields)
		lumniClose(@communication_template,communicationTemplateResult,list: communication_templates_fields)
	end

	def destroy
		@communication_template = CommunicationTemplate.lumniStart(params,current_company,list: communication_templates_fields)
		communicationTemplateResult = @communication_template.lumniSave(params,current_user,list: communication_templates_fields)
		lumniClose(@cluster,communicationTemplateResult,list: communication_templates_fields)
	end

	def preview
		@communication_template = CommunicationTemplate.cached_find(params[:id])
		respond_to do |format|
	      format.pdf do
	        render(
        		pdf: '/communication_templates/preview',
        		encoding: 'UTF8',
        		page_size: 'letter',
        		margin:  {  
        			top:               20,
              bottom:            20,
              left:              20,
              right:             20 
           	}
          )
	      end
	    end		
	end
end
