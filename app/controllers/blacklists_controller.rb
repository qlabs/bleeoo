raw_config = File.read(RAILS_ROOT + "/tmp/credentials.yml")
CREDENTIALS = YAML.load(raw_config)[RAILS_ENV]

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
    @blacklist = Blacklist.new(params[:blacklist])

    respond_to do |format|
      if @blacklist.save
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
      id == CREDENTIALS["username"] && password == CREDENTIALS["password"]
    end
  end

end