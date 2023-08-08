# frozen_string_literal: true

class User < ApplicationRecord
  NAME_LENGTH_MIN = 1
  NAME_LENGTH_MAX = 30
  PASSWORD_LENGTH_MIN = 6
  EMAIL_LENGTH_MAX = 255
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # regex for email: https://qiita.com/HIROKOBA/items/1358aa2e9652688698ee

  has_many :user_records
  has_many :records, through: :user_records

  validates :name, presence: true, length: { minimum: NAME_LENGTH_MIN, maximum: NAME_LENGTH_MAX }
  validates :email, presence: false, length: { maximum: EMAIL_LENGTH_MAX },
                    allow_blank: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: PASSWORD_LENGTH_MIN }

  before_save :prepare_for_save
  def prepare_for_save
    # &. : https://thoughtbot.com/blog/ruby-safe-navigation
    email&.downcase!
  end

  after_create :oncreate
  def oncreate
    puts 'Successfully created a new user: ' \
         "ID - #{id}, Name: #{name} ."
  end
end
