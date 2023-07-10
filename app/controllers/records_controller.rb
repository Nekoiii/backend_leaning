class RecordsController < ApplicationController
  before_action :set_record, only: [:show]

  def index
    @records=Record.all
  end
  
  def new
    @record=Record.new
  end

  def show;end

  def set_record
    @record=Record.find(params[:id])
  end

  
  end  