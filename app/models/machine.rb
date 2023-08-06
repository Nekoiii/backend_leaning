class Machine < ApplicationRecord
  has_many :records

  def oncreate
    puts 'Successfully created a new machine'
  end
end
