class RecordsController < ApplicationController
  before_action :set_record, only: [:show]

  def index
    @records=Record.all
  end
  
  def new
    @record=Record.new
  end


  def set_record
    @record=Record.find(params[:id])
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to records_path, notice: "Record with ID #{params[:id]} was successfully deleted."
  end

  def edit
    @record=Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
  
    if @record.update(record_params)
      redirect_to @record, notice: "Record with ID #{params[:id]} was successfully updated."
    else
      render :edit
    end
  end
  

  private

  def record_params
    params.require(:record).permit(:record_type, :title, 
      :content, :machine_id, :user_id, :images => [])
  end


  def add_images
    config = Rails.application.config_for(:storage)
    bucket_name = config['amazon']['bucket']
    region= config['amazon']['region']
    
    @record = Record.find(params[:id])
    image_files = params[:images] 
    
    s3 = Aws::S3::Resource.new(region: region)
    
    image_files.each do |image_file|
      """name = File.basename(image_file.path)
      obj = s3.bucket(bucket_name).object(name)
      obj.upload_file(image_file.path, acl: 'public-read')
    
      image = Image.new(image_path: obj.public_url)
      image.record = @record
      image.save!"""
      name = image_file.original_filename
      obj = s3.bucket(bucket_name).object(name)
      obj.put(body: File.read(image_file.tempfile), acl: 'public-read')
    
      image = Image.new(image_path: obj.public_url)
      image.record = @record
      image.save!
    end
  
    Rails.logger.debug "add_images called with #{params[:images].length} images"

    redirect_to @record
  end
  

  
  end  