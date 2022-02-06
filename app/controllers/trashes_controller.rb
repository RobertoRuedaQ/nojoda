class TrashesController < ApplicationController
	def index
		@trash = Trash.lumniStart(params,current_company)
		trashResult = @trash.lumniSave(params,current_user)
		lumniClose(@trash,trashResult)
	end

	def new
		@trash = Trash.lumniStart(params,current_company)
		trashResult = @trash.lumniSave(params,current_user)
		lumniClose(@trash,trashResult)
	end

	def create
		@trash = Trash.lumniStart(params,current_company)
		trashResult = @trash.lumniSave(params,current_user)
		lumniClose(@trash,trashResult)
	end

	def edit
		@trash = Trash.lumniStart(params,current_company)
		trashResult = @trash.lumniSave(params,current_user)
		lumniClose(@trash,trashResult)
	end

	def update
		@trash = Trash.lumniStart(params,current_company)
		trashResult = @trash.lumniSave(params,current_user)
		lumniClose(@trash,trashResult)
	end
	def destroy
		@trash = Trash.lumniStart(params,current_company)
		trashResult = @trash.lumniSave(params,current_user)
		lumniClose(@trash,trashResult)
	end

	def remove_attachment
		target_record = eval("#{params[:target_model]}.cached_find(params[:id])")
		if params[:specific_field].nil?
			target_record.send(params[:target_field]).purge
		else
			to_drop = target_record.send(params[:target_field]).find(params[:specific_field])
			if to_drop.present?
				to_drop.purge
			end
		end
	end
end
