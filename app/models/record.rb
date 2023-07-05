class Record < ApplicationRecord
  belongs_to :machine

  validate :title, presence: true
  validate :content 
  validate :type 
  validate :machine 

end
