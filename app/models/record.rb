class Record < ApplicationRecord
  belongs_to :machine

  validates :title, presence: true

end
