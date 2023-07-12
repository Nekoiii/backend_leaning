class Record < ApplicationRecord
  belongs_to :machine
  belongs_to :user

  validates :title, presence: true

  enum record_type: { hygiene: 0, temperature: 1 ,humidity:3}

end
