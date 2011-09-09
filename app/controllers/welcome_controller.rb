class WelcomeController < ApplicationController
  # GET /
  def index
    @video_uid = UUID.generate    
    @videos = Video.is_published.paginate :page => (params[:page] || 1) , :order => 'created_at DESC', :per_page => 4
  end

end
