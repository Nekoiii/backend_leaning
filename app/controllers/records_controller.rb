# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :set_record, only: %i[show destroy edit update]
  before_action :set_title
  before_action :logged_in_user, only: %i[new create]

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
    @records = Record.all.order(created_at: :desc)
    @totle_records_count = Record.count
    @overflow_records_count = Record.where(
      record_status: Types::RecordStatusEnumType::RECORD_STATUS.keys[1].to_s
    ).count
  end

  def new
    # Use another layout instead fo the default one
    @title = 'New Record'
    @record = Record.new
    render layout: 'test_layout_1'
  end

  def create
    Rails.logger.debug("create-record-params---#{params}")
    Rails.logger.debug("create-record-record_params---#{params}")
    @record = Record.new(record_params)
    if @record.save
      flash[:info] = 'Successfully create a new record!'
    else
      flash[:danger] = 'Failed to create new record!'
    end
    redirect_to records_path
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
    Rails.logger.debug "params[:record][:images]: #{params[:record][:images].inspect}--"

    if @record.update(record_params)
      redirect_to @record, notice: "Record with ID #{params[:id]} was successfully updated."
    else
      render :edit
    end
  end

  private

    def attach_images
      Rails.logger.debug "attach images--- #{params[:record][:images].inspect}--"
      params[:record][:images] = @record.images.attach(params[:record][:images])
    end

    def delete_images
      params[:images_to_delete].each do |image_id|
        image = @record.images.find(image_id)
        image.purge
      end
    end


  private
    # strong parameters: https://ichigick.com/rails-strong-parameter/
    def record_params
      params.require(:record).permit(
        :title, :content,
        :machine_id, :record_type, :record_status,
        images: [], images_to_delete: [], user_ids: []
      )
    end

end
