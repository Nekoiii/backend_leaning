class Record < ApplicationRecord
  belongs_to :machine

  has_many :user_records
  has_many :users, through: :user_records
  has_many_attached :images

  validates :title, presence: true

  # hygiene: 衛生, temperature: 温度, humidity: 湿度
  RECORD_TYPES = { hygiene: 0, temperature: 1, humidity: 2 }
  enum record_type: RECORD_TYPES
  # normal: 正常, overflow: 逸脱, resolved: 対応済
  RECORD_STATUS = { normal: 0, overflow: 1, resolved: 2 }
  enum record_status: RECORD_STATUS

  def oncreate
    puts 'Successfully created a new record'
  end
end
