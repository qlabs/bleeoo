class VideosController < ApplicationController
  before_filter :fetch_video, :except => [:callback,:index,:create, :like, :tweet]
  # before_filter :block_blacklisted_ips, :only => [:create]
  
  def index    
    @videos = Video.is_published.paginate :page => (params[:page] || 1) , :order => 'created_at DESC', :per_page => 12
  end
  
  def delete
    logger.info("delete #{@video.framey_name}")

    success = true
    begin
      time_stamp = (DateTime.now + 1.day).to_i
      api_key = Framey.api_key
      signature = Digest::MD5.hexdigest("#{Framey.api_secret}&#{time_stamp}")      
      
      
      url = "#{Framey.api_host}/api/videos/#{@video.framey_name}?api_key=#{api_key}&time_stamp=#{time_stamp}&signature=#{signature}"
      
      logger.info(url)
      # logger.info(options.inspect)
      logger.info(HTTParty.delete("#{url}").inspect)
      
      @video.destroy
      
    rescue Exception => e
      logger.warn(e.message)
      success = false
    end

    render :nothing => true, :json => {:success => success}.to_json and return
  end
  
  # Create a video object after a user finishes recording and clicks "Publish"
  # The publish hook in the Framey recorder calls a JS function that posts 
  # the UUID of a video.  When the callback is made, the video uid is in the Framey
  # session data so that this object can be looked up and 
  def create
    if video = Video.create(:uid => params[:video_uid], :ip_address => request.remote_ip)
      @success = true
      
      # create the URL of the video
      video_url = "#{BLEEOO_HOST}/videos/#{params[:video_uid]}"  
      begin 
        bitly = Bitly.new(BITLY_USER, BITLY_API_KEY)
        logger.info("url: #{video_url}")
        puts "url: #{video_url}"
        url = bitly.shorten(video_url)
        @short_url = url.short_url
      rescue 
        @short_url = ""
      end
      
      video.short_link = @short_url
      video.save
      
    else
      @success = false      
    end
    
    logger.info("success == #{@success}")
    # respond_to do |format|
    #   format.html
    #   format.js {render :json => {:success => @success, :short_url => @short_url}.to_json }
    # end
    
    render :nothing => true, :json => {:success => @success, :short_url => @short_url}.to_json and return
    
  end
  
  # framey callback
  def callback
    render :text => "" and return unless request.post? && params[:video]

    puts params.inspect
    video_uid = params[:video][:data][:video_uid]
    name = params[:video][:name]
    video_url = params[:video][:flv_url]
    thumbnail_url = params[:video][:large_thumbnail_url]
    
    video = Video.find_by_uid(video_uid)
    
    if !video
      puts "didn't find vid, creating it"
      video = Video.create!({
        :uid => video_uid,
        :framey_name => name,
        :framey_video_url => video_url,
        :framey_thumbnail_url => thumbnail_url
      })
    else
      "Found vid, updating it"
      video.framey_name = name
      video.framey_video_url = video_url
      video.framey_thumbnail_url = thumbnail_url
      video.published = true
      video.save
    end
    
    render :text => "" and return
  end
  
  def show
  end
  
  def source
    @video.viewed!
    redirect_to @video.framey_video_url and return
  end
  
  def thumbnail
    if @video.framey_thumbnail_url 
      redirect_to @video.framey_thumbnail_url and return
    else
      redirect_to "/images/default_thumbnail.png" and return
    end
  end
  
  private
  
  def block_blacklisted_ips
    ip = request.remote_ip
    if User.find_by_ip_address(ip)
      Rails.logger.debug "Caught a blocked IP ========> #{ip}"
      redirect_to "http://www.youtube.com/watch?v=QH2-TGUlwu4"
    end
  end

  def fetch_video
    @video = Video.find_by_uid(params[:uid])
    four_oh_four and return unless @video
  end
end
