class ApplicationController < ActionController::Base
  protect_from_forgery
  
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
