class AssetsController < ApplicationController
  before_filter :authenticate_user! # requires autenthentification before any acion
  def index
    @assets = current_user.assets
  end

  def show
    @asset = current_user.assets.find(params[:id])
  end

  def new
    @asset = current_user.assets.new
  end

  def create
    @asset = current_user.assets.new(params[:asset])
    if @asset.save
      redirect_to @asset, :notice => "Successfully created asset."
    else
      render :action => 'new'
    end
  end

  def edit
    @asset = current_user.assets.find(params[:id])
  end

  def update
    @asset = current_user.assets.find(params[:id])
    if @asset.update_attributes(params[:asset])
      redirect_to @asset, :notice  => "Successfully updated asset."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset = current_user.assets.find(params[:id])
    @asset.destroy
    redirect_to assets_url, :notice => "Successfully destroyed asset."
  end
  
  # Find asset, if there is any, it will send it to the user
  def get
	@asset = current_user.assets.find_by_id(params[:id])
	if @asset
		send_file @asset.uploaded_file.path, :type => @asset.uploaded_file_content_type
	else
		flash[:error] = "Hey, what are u doin?!"
		redirect_to assets_path
	end
  end
  
end
