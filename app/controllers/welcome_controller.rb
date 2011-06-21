class WelcomeController < ApplicationController
  # GET /
  def index
   @videos = Video.paginate :page => (params[:page] || 1) , :order => 'created_at DESC', :per_page => 4
  end

end
