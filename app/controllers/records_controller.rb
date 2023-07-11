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
    redirect_to records_path, notice: "Record  with ID #{params[:id]} was successfully deleted."
  end



  
  end  