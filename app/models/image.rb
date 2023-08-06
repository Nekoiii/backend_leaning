class Image < ApplicationRecord
  belongs_to :record

  def oncreate
    puts 'Successfully created a new image'
  end
end
