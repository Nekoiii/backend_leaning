class RecordsController < ApplicationController
  before_action :set_record, only: [:show]
  before_action :set_title

  def set_title
    @title = "Record"
  end

  def index  
    # Debug : https://codeclub965.com/?p=1520
    #Rails.logger.debug "aaaaaaa"
    @records=Record.all
    @totle_records_count=Record.count
    @overflow_records_count = Record.where(record_status: 'overflow').count
  end
  
  def new
    @title = "New Record"
    # Use another layout instead fo the default one
    render layout: 'test_layout_1'
    @record=Record.new
  end


  def set_record
    @record=Record.find(params[:id])
    @users = @record.users
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

    # Update images with .attach() instead of replacing old ones
    # params methos: https://ichigick.com/rails-params/
    if params[:record][:images]
      params[:record][:images] = @record.images.attach(params[:record][:images])
    end

    Rails.logger.debug "Images to delete: #{params[:images_to_delete]}-----"
    if params[:images_to_delete]
      images_to_delete = params[:images_to_delete]
      images_to_delete.each do |image_id|
        image = @record.images.find(image_id)
        image.purge
      end
    end

    Rails.logger.debug "record params--: #{params}--"
    Rails.logger.debug "record params: #{record_params}--"
    if @record.update(record_params)
      redirect_to @record, notice: "Record with ID #{params[:id]} was successfully updated."
    else
      render :edit
    end
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
  
  private

  # strong parameters: https://ichigick.com/rails-strong-parameter/
  def record_params
    params.require(:record).permit(
      :title, :content, 
      :machine_id, :record_type, :record_status,
      :images => [], :images_to_delete => [], :user_ids => [])
  end


  end  