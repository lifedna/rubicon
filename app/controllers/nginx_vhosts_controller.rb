class NginxVhostsController < ApplicationController
  def index
    # mongodb lacks insensitive sorting
    @nginx_vhosts = NginxVhost.all.asc(:dns_name,:upstream_port,:name,:environment)
  end

  def new
    @nginx_vhost = NginxVhost.new
    @web_apps    = WebApp.all.asc(:name)
    @machines    = Machine.all.asc(:dns_name)
    @web_servers = WebServer.all.asc(:short_name)
  end

  def edit
    @nginx_vhost = NginxVhost.find(params[:id])
    @web_apps    = WebApp.all.asc(:name)
    @machines    = Machine.all.asc(:dns_name)
    @web_servers = WebServer.all.asc(:short_name)
  end

  def show
    @nginx_vhost = NginxVhost.find(params[:id])
  end

  def create
    @nginx_vhost = NginxVhost.new(params[:nginx_vhost])

    respond_to do |format|
      if @nginx_vhost.save
        format.html { redirect_to nginx_vhosts_url,
                      notice: 'Web App Instance was successfully created.' }
        format.json { render json: @nginx_vhost,
                             status: :created,
                             location: @nginx_vhost }
      else
        flash.now[:error] = "There was a problem"
        format.html { render action: "new" }
        format.json { render json: @nginx_vhost.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  def update
    @nginx_vhost = NginxVhost.find(params[:id])

    respond_to do |format|
      if @nginx_vhost.update_attributes(params[:nginx_vhost])
        format.html { redirect_to nginx_vhosts_url,
                      notice: 'Web App Instance was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @nginx_vhost.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @nginx_vhost = NginxVhost.find(params[:id])
    @nginx_vhost.destroy

    respond_to do |format|
      format.html { redirect_to nginx_vhosts_url }
      format.json { head :ok }
    end
  end

end
