class Record < ApplicationRecord
  belongs_to :machine

  validates :title, presence: true
  validates :content 
  validates :type 
  validates :machine 

end
