class Record < ApplicationRecord
  belongs_to :machine
  belongs_to :user

  validates :title, presence: true

end
