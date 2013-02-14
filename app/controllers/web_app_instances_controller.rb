class WebAppInstancesController < ApplicationController
  def index
    # mongodb lacks insensitive sorting
    @web_app_instances = WebAppInstance.all.asc(:dns_name,:downstream_port,:name,:environment)
  end

  def new
    @web_app_instance = WebAppInstance.new
    @web_apps         = WebApp.all.asc(:name)
    @machines         = Machine.all.asc(:dns_name)
    @web_servers      = WebServer.all.asc(:short_name)
  end

  def edit
    @web_app_instance = WebAppInstance.find(params[:id])
    @web_apps         = WebApp.all.asc(:name)
    @machines         = Machine.all.asc(:dns_name)
    @web_servers      = WebServer.all.asc(:short_name)
  end

  def show
    @web_app_instance = WebAppInstance.find(params[:id])
  end

  def create
    @web_app_instance = WebAppInstance.new(params[:web_app_instance])

    respond_to do |format|
      if @web_app_instance.save
        format.html { redirect_to web_app_instances_url, notice: 'Web App Instance was successfully created.' }
        format.json { render json: @web_app_instance, status: :created, location: @web_app_instance }
      else
        flash.now[:error] = "There was a problem"
        format.html { render action: "new" }
        format.json { render json: @web_app_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @web_app_instance = WebAppInstance.find(params[:id])

    respond_to do |format|
      if @web_app_instance.update_attributes(params[:web_app_instance])
        format.html { redirect_to web_app_instances_url, notice: 'Web App Instance was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_app_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @web_app_instance = WebAppInstance.find(params[:id])
    @web_app_instance.destroy

    respond_to do |format|
      format.html { redirect_to web_app_instances_url }
      # format.json { head :ok }
    end
  end

end
