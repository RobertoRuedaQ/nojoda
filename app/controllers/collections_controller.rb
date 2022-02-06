class CollectionsController < ApplicationController
	def index
		@collection = Collection.lumniStart(params,current_company, list: current_user.template('Collection','collections',current_user)).order(created_at: :desc).limit(300)
		contactCollection = @collection.lumniSave(params,current_user, list: current_user.template('Collection','collections',current_user))
		lumniClose(@collection,contactCollection)
	end

	def new
		if !params[:user_id].nil?
			@collection = Collection.lumniStart(params,current_company, list: current_user.template('Collection','collections',current_user))
			@collection.user_id = params[:user_id]
			contactCollection = @collection.lumniSave(params,current_user, list: current_user.template('Collection','collections',current_user))
			lumniClose(@collection,contactCollection)
		else
			redirect_to root_path
		end
	end

	def create
		@collection = Collection.lumniStart(params,current_company, list: current_user.template('Collection','collections',current_user))
		@collection.owner_id = current_user.id
		contactCollection = @collection.lumniSave(params,current_user, list: current_user.template('Collection','collections',current_user))
		lumniClose(@collection,contactCollection)
	end

	def edit
		@collection = Collection.lumniStart(params,current_company, list: current_user.template('Collection','collections',current_user))
		contactCollection = @collection.lumniSave(params,current_user, list: current_user.template('Collection','collections',current_user))
		lumniClose(@collection,contactCollection)
	end

	def update
		@collection = Collection.lumniStart(params,current_company, list: current_user.template('Collection','collections',current_user))
		contactCollection = @collection.lumniSave(params,current_user, list: current_user.template('Collection','collections',current_user))
		lumniClose(@collection,contactCollection)
	end
	def destroy
		@collection = Collection.lumniStart(params,current_company, list: current_user.template('Collection','collections',current_user))
		contactCollection = @collection.lumniSave(params,current_user, list: current_user.template('Collection','collections',current_user))
		lumniClose(@cluster,contactCollection)
	end
end