class BlacklistsController < ApplicationController

  before_filter :authenticate
  # GET /blacklists
  # GET /blacklists.xml
  def index
    @blacklists = Blacklist.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blacklists }
    end
  end

  # GET /blacklists/1
  # GET /blacklists/1.xml
  def show
    @blacklist = Blacklist.find(params[:id])
    @videos = Video.find_all_by_remote_ip(@blacklist.remote_ip)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blacklist }
    end
  end

  # GET /blacklists/new
  # GET /blacklists/new.xml
  def new
    @blacklist = Blacklist.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blacklist }
    end
  end

  # GET /blacklists/1/edit
  def edit
    @blacklist = Blacklist.find(params[:id])
  end

  # POST /blacklists
  # POST /blacklists.xml
  def create
    ip = retrieve_ip(params[:uid])
    @blacklist = Blacklist.new(:remote_ip => ip)

    respond_to do |format|
      if @blacklist.save
        vids = Video.find_all_by_remote_ip(ip)
        vids.each do |vid|
          vid.published = false
          vid.save
        end
        format.html { redirect_to(@blacklist, :notice => 'Blacklist was successfully created.') }
        format.xml  { render :xml => @blacklist, :status => :created, :location => @blacklist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blacklist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blacklists/1
  # PUT /blacklists/1.xml
  def update
    @blacklist = Blacklist.find(params[:id])

    respond_to do |format|
      if @blacklist.update_attributes(params[:blacklist])
        format.html { redirect_to(@blacklist, :notice => 'Blacklist was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blacklist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blacklists/1
  # DELETE /blacklists/1.xml
  def destroy
    @blacklist = Blacklist.find(params[:id])
    @blacklist.destroy

    respond_to do |format|
      format.html { redirect_to(blacklists_url) }
      format.xml  { head :ok }
    end
  end
  
private
  def authenticate
    authenticate_or_request_with_http_basic do |id, password| 
      id == ENV["USERNAME"] && password == ENV["PASSWORD"]
    end
  end

  def retrieve_ip(uid)
    Video.find_by_uid(uid).remote_ip
  end

end
