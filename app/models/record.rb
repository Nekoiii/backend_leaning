class Record < ApplicationRecord
  belongs_to :machine
  belongs_to :user

  has_many_attached :images

  validates :title, presence: true

  RECORD_TYPES = { hygiene: 0, temperature: 1, humidity: 2 }
  enum record_type: RECORD_TYPES

  RECORD_STATUS = { normal: 0, overflow: 1, resolved: 2 }
  enum record_status: RECORD_STATUS

  def oncreate
    puts 'Successfully created a new record'
  end


end
