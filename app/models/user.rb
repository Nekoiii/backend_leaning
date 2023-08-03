class User < ApplicationRecord
  
  has_many :user_records
  has_many :records, through: :user_records
  
  validates :name, presence: true, length:{minimum:1, maximum:30}


  after_create :oncreate

  def oncreate
    puts 'Successfully created a new user'
  end



end
