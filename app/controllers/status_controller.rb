class StatusController < ApplicationController
  
  def index
    render :text => "As of #{Time.now} #{request.host} is up and running! #{status_video}", :layout => "application"
  end
  
  
  def status_video
    %q|<br/><iframe width="420" height="315" src="http://www.youtube.com/embed/9ekIzGfJkBs?autoplay=1" frameborder="0" allowfullscreen ></iframe>|
  end
end