class WebServersController < ApplicationController
  def index
    @web_servers = WebServer.all.asc(:short_name)
  end

  def new
    @web_server = WebServer.new
  end

  def edit
    @web_server = WebServer.find(params[:id])
  end

  def show
    @web_server = WebServer.find(params[:id])
  end

  def create
    @web_server = WebServer.new(params[:web_server])

    respond_to do |format|
      if @web_server.save
        format.html { redirect_to web_servers_url, notice: 'Web Server was successfully created.' }
        format.json { render json: @web_server, status: :created, location: @web_server }
      else
        flash.now[:error] = "There was a problem"
        format.html { render action: "new" }
        format.json { render json: @web_server.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @web_server = WebServer.find(params[:id])

    respond_to do |format|
      if @web_server.update_attributes(params[:web_server])
        format.html { redirect_to @web_server, notice: 'Web Server was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @web_server.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @web_server = WebServer.find(params[:id])
    @web_server.destroy

    respond_to do |format|
      format.html { redirect_to web_servers_url }
      # format.json { head :ok }
    end
  end

end