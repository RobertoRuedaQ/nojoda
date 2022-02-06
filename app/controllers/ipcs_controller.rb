class IpcsController < ApplicationController
	def index
		@ipc = Ipc.lumniStart(params,current_company, list: current_user.template('Ipc','ipcs',current_user))
		contactIpc = @ipc.lumniSave(params,current_user, list: current_user.template('Ipc','ipcs',current_user))
		lumniClose(@ipc,contactIpc)
	end

	def new
		@ipc = Ipc.lumniStart(params,current_company, list: current_user.template('Ipc','ipcs',current_user))
		contactIpc = @ipc.lumniSave(params,current_user, list: current_user.template('Ipc','ipcs',current_user))
		lumniClose(@ipc,contactIpc)
	end

	def create
		@ipc = Ipc.lumniStart(params,current_company, list: current_user.template('Ipc','ipcs',current_user))
		contactIpc = @ipc.lumniSave(params,current_user, list: current_user.template('Ipc','ipcs',current_user))
		lumniClose(@ipc,contactIpc)
	end

	def edit
		@ipc = Ipc.lumniStart(params,current_company, list: current_user.template('Ipc','ipcs',current_user))
		contactIpc = @ipc.lumniSave(params,current_user, list: current_user.template('Ipc','ipcs',current_user))
		lumniClose(@ipc,contactIpc)
	end

	def update
		@ipc = Ipc.lumniStart(params,current_company, list: current_user.template('Ipc','ipcs',current_user))
		contactIpc = @ipc.lumniSave(params,current_user, list: current_user.template('Ipc','ipcs',current_user))
		lumniClose(@ipc,contactIpc)
	end
	def destroy
		@ipc = Ipc.lumniStart(params,current_company, list: current_user.template('Ipc','ipcs',current_user))
		contactIpc = @ipc.lumniSave(params,current_user, list: current_user.template('Ipc','ipcs',current_user))
		lumniClose(@cluster,contactIpc)
	end
end