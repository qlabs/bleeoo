class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :ensure_domain

  APP_DOMAIN = 'bleeoo.com'

  def ensure_domain
    if request.env['HTTP_HOST'] != APP_DOMAIN && Rails.env == "production"
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
  def index
  end
  
  private 
  
  def four_oh_four
    render :file => File.join(Rails.root,"public","404.html"), :status => 404 and return
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
end
