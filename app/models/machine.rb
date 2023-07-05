class Machine < ApplicationRecord
  has_many :record

  validates :record_ids 
end
