# frozen_string_literal: true

class MachinesController < ApplicationController
  def index
    @machines = Machine.all
  end

  def new
    @machine = Machine.new
  end

  def show
    @machine = Machine.find(params[:id])
  end
end
