# frozen_string_literal: true

class UserRecord < ApplicationRecord
  belongs_to :user
  belongs_to :record

  after_create :oncreate

  def oncreate
    puts "Successfully created a UserRecord: user_id #{user_id} -  record_id#{record_id}"
  end

end
