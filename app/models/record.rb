class Record < ApplicationRecord
  belongs_to :machine
  belongs_to :user

  has_many_attached :imgs

  validates :title, presence: true

  RECORD_TYPES = { hygiene: 0, temperature: 1, humidity: 2 }
  enum record_type: RECORD_TYPES


end
