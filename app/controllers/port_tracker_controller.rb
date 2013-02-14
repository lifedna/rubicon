class PortTrackerController < ApplicationController

  def index
    @web_app_instances = WebAppInstance.default
    @machines          = Machine.all
  end

end
