class AssetsController < ApplicationController
  before_filter :authenticate_user! # Requires autenthentification before any acion
  def index
    @assets = current_user.assets
  end

  def show
    @asset = current_user.assets.find(params[:id])
  end

  def new
    @asset = current_user.assets.build # Build method because of folder_id
    if params[:folder_id] # If we want to upload a file inside another folder  
      @current_folder = current_user.folders.find(params[:folder_id])  
      @asset.folder_id = @current_folder.id  
    end
  end

  def create
    @asset = current_user.assets.build(params[:asset])  
    if @asset.save  
      flash[:notice] = "Successfully uploaded the file."  
  
      if @asset.folder # Checking if we have a parent folder for this file  
        redirect_to browse_path(@asset.folder)  # Then we redirect to the parent folder  
      else  
        redirect_to root_url  
      end        
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
