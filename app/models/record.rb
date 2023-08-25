# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :machine, optional: true

  has_many :user_records, dependent: :destroy
  has_many :users, through: :user_records
  has_many_attached :images

  validates :title, presence: true

  enum record_type: Types::RecordEnumType::RECORD_TYPES
  enum record_status: Types::RecordStatusEnumType::RECORD_STATUS

  after_create :oncreate

  private
    def oncreate
      puts "Successfully created a new record: #{id}"
    end
end
