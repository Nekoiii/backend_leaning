class User < ApplicationRecord
  NAME_LENGTH_MIN = 1
  NAME_LENGTH_MAX = 30

  has_many :user_records
  has_many :records, through: :user_records
  
  validates :name, presence: true, length:{minimum:NAME_LENGTH_MIN, maximum:NAME_LENGTH_MAX}
  validates :email, presence: false


  after_create :oncreate

  def oncreate
    puts 'Successfully created a new user'
  end



end
