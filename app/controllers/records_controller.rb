# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :set_record, only: %i[show destroy edit update]
  before_action :set_title

  def set_record
    @record = Record.find(params[:id])
    @users = @record.users
    @machine = @record.machine
  end

  def set_title
    @title = 'Record'
  end

  def index
    # Rails.logger.debug : https://codeclub965.com/?p=1520
    # Rails.logger.debug 'qqqqq'+Types::RecordStatusEnumType::RECORD_STATUS.keys[1].to_s
    @records = Record.all
    @totle_records_count = Record.count
    @overflow_records_count = Record.where(
      record_status: Types::RecordStatusEnumType::RECORD_STATUS.keys[1].to_s
    ).count
  end

  def new
    # Use another layout instead fo the default one
    @title = 'New Record'
    render layout: 'test_layout_1'
    @record = Record.new
  end

  def destroy
    @record.destroy
    redirect_to records_path, notice: "Record with ID #{params[:id]} was successfully deleted."
  end

  def edit; end

  def update
    # Update images with .attach() instead of replacing old ones
    # params methos: https://ichigick.com/rails-params/
    attach_images if params[:record][:images]
    delete_images if params[:images_to_delete]

    Rails.logger.debug "Images to delete: #{params[:images_to_delete]}-----"

    Rails.logger.debug "record params--: #{params}--"
    Rails.logger.debug "record params: #{record_params}--"
    if @record.update(record_params)
      redirect_to @record, notice: "Record with ID #{params[:id]} was successfully updated."
    else
      render :edit
    end
  end

  private

  def attach_images
    params[:record][:images] = @record.images.attach(params[:record][:images])
  end

  def delete_images
    params[:images_to_delete].each do |image_id|
      image = @record.images.find(image_id)
      image.purge
    end
  end

  public

  def add_images
    config = Rails.application.config_for(:storage)
    bucket_name = config['amazon']['bucket']
    region = config['amazon']['region']

    @record = Record.find(params[:id])
    image_files = params[:images]

    s3 = Aws::S3::Resource.new(region:)

    image_files.each do |image_file|
      upload_image_to_s3(image_file, s3, bucket_name)
    end

    Rails.logger.debug "add_images called with #{params[:images].length} images"

    redirect_to @record
  end

  private

  def upload_image_to_s3(image_file, s3, bucket_name)
    name = image_file.original_filename
    obj = s3.bucket(bucket_name).object(name)
    obj.put(body: File.read(image_file.tempfile), acl: 'public-read')

    image = Image.new(image_path: obj.public_url)
    image.record = @record
    image.save!
  end

  # strong parameters: https://ichigick.com/rails-strong-parameter/
  def record_params
    params.require(:record).permit(
      :title, :content,
      :machine_id, :record_type, :record_status,
      images: [], images_to_delete: [], user_ids: []
    )
  end
end
