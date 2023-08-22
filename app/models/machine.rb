# frozen_string_literal: true

class Machine < ApplicationRecord
  has_many :records

  after_create :oncreate

  def oncreate
    puts "Successfully created a new machine: #{id}"
  end
end
