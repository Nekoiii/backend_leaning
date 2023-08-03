class User < ApplicationRecord
  NAME_LENGTH_MIN = 1
  NAME_LENGTH_MAX = 30
  # regex for email: https://qiita.com/HIROKOBA/items/1358aa2e9652688698ee
  EMAIL_LENGTH_MAX = 255
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  

  has_many :user_records
  has_many :records, through: :user_records
  
  validates :name, presence: true, length:{minimum:NAME_LENGTH_MIN, maximum:NAME_LENGTH_MAX}
  validates :email, presence: false, length:{maximum:EMAIL_LENGTH_MAX},
                                     format: { with: VALID_EMAIL_REGEX, allow_blank: true},
                                     uniqueness: { case_sensitive: false, allow_blank: true}


  before_save :prepare_for_save
  def prepare_for_save
    self.email = email.downcase
  end

  after_create :oncreate
  def oncreate
    puts "Successfully created a new user: " <<
          "ID - #{self.id}, Name: #{self.name} ."
  end



end
