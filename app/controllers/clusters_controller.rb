class ClustersController < ApplicationController
  def index
    @cluster = Cluster.lumniStart(params,current_company, list: current_user.template('Cluster','clusters',current_user)).limit(1000)
    clusterResult = @cluster.lumniSave(params,current_user, list: current_user.template('Cluster','clusters',current_user))
    lumniClose(@cluster,clusterResult)
  end

  def new
    @cluster = Cluster.lumniStart(params,current_company, list: current_user.template('Cluster','clusters',current_user))
    set_major
    clusterResult = @cluster.lumniSave(params,current_user, list: current_user.template('Cluster','clusters',current_user))
    lumniClose(@cluster,clusterResult)
  end

  def create
    @cluster = Cluster.lumniStart(params,current_company, list: current_user.template('Cluster','clusters',current_user))
    clusterResult = @cluster.lumniSave(params,current_user, list: current_user.template('Cluster','clusters',current_user))
    lumniClose(@cluster,clusterResult)
  end

  def edit
    @cluster = Cluster.lumniStart(params,current_company, list: current_user.template('Cluster','clusters',current_user))
    clusterResult = @cluster.lumniSave(params,current_user, list: current_user.template('Cluster','clusters',current_user))
    lumniClose(@cluster,clusterResult)
  end

  def update
    @cluster = Cluster.lumniStart(params,current_company, list: current_user.template('Cluster','clusters',current_user))
    clusterResult = @cluster.lumniSave(params,current_user, list: current_user.template('Cluster','clusters',current_user))
    lumniClose(@cluster,clusterResult)
  end
  
  def destroy
    @cluster = Cluster.lumniStart(params,current_company, list: current_user.template('Cluster','clusters',current_user))
    clusterResult = @cluster.lumniSave(params,current_user, list: current_user.template('Cluster','clusters',current_user))
    lumniClose(@cluster,clusterResult)
  end

  private

  def set_major
    return unless params[:major_id]

    @cluster.major_id = params[:major_id]
  end
end
