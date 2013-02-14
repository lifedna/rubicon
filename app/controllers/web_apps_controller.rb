class WebAppsController < ApplicationController
  def index
    # mongodb lacks insensitive sorting
    @web_apps = WebApp.all.sort_by(&:name)
  end

  def new
    @web_app = WebApp.new
  end

  def edit
    @web_app = WebApp.find(params[:id])
  end

  def show
    @web_app      = WebApp.find(params[:id])
    @nginx_vhosts = NginxVhost.where(name: @web_app.name)
    @wais         = WebAppInstance.where(name: @web_app.name)
  end

  def create
    @web_app = WebApp.new(params[:web_app])

    respond_to do |format|
      if @web_app.save
        format.html { redirect_to web_apps_url, notice: 'Web App was successfully created.' }
        format.json { render json: @web_app, status: :created, location: @web_app }
      else
        flash.now[:error] = "There was a problem"
        format.html { render action: "new" }
        format.json { render json: @web_app.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @web_app = WebApp.find(params[:id])

    respond_to do |format|
      if @web_app.update_attributes(params[:web_app])
        format.html { redirect_to web_apps_url, notice: 'Web App was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_app.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @web_app = WebApp.find(params[:id])
    @web_app.destroy

    respond_to do |format|
      format.html { redirect_to web_apps_url }
      # format.json { head :ok }
    end
  end

end
