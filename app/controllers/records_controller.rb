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
    params.require(:record).permit(:record_type, :title, :content, :machine_id, :user_id)
  end




  
  end  