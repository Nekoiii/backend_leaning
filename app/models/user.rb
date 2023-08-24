# frozen_string_literal: true

class User < ApplicationRecord
  NAME_LENGTH_MIN = 1
  NAME_LENGTH_MAX = 30
  PASSWORD_LENGTH_MIN = 6
  EMAIL_LENGTH_MAX = 255
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # regex for email: https://qiita.com/HIROKOBA/items/1358aa2e9652688698ee

  attr_accessor :remember_token, :activation_token

  has_one_attached :avatar 
  has_many :user_records
  has_many :records, through: :user_records

  validates :name, presence: true, length: { minimum: NAME_LENGTH_MIN, maximum: NAME_LENGTH_MAX }
  validates :email, presence: false, length: { maximum: EMAIL_LENGTH_MAX },
                    allow_blank: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  # No need to added password col but password_digest col in uses table when using has_secure_password
  has_secure_password
  # has_secure_password will check for nil so can use 'allow_nil: true' here, 
  # (or it will fail when editting user profile if the password is not filled in.)
  validates :password, presence: true, length: { minimum: PASSWORD_LENGTH_MIN }, allow_nil: true

  after_create :oncreate
  before_save :downcase_email
  before_create :create_activation_digest

  
  # Create a new token and store in :remember_token
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest # Return remember_digest (used for 'def session_token' after)
  end
  
  # Returns the session token to prevent session hijacking
  # Reuses the remember digest for convenience
  def session_token
    remember_digest || remember
  end

  # Check if token is matched
  # def authenticated?(remember_token)
  #   return false if remember_digest.nil?
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activate account
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  private

    def downcase_email
      # &. : https://thoughtbot.com/blog/ruby-safe-navigation
      email&.downcase!
    end

    def oncreate
      puts 'Successfully created a new user: ' \
          "ID - #{id}, Name: #{name} ."
    end
    
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end



  class << self
    # https://railstutorial.jp/chapters/basic_login?version=7.0#cha-basic_login
    # ( It's for test/fixtures/users.yml)
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end


end
