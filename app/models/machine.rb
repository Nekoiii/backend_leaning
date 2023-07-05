class Machine < ApplicationRecord
  has_many :record

  validate :record_ids 
end
