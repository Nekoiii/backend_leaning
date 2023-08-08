# frozen_string_literal: true

class UserRecord < ApplicationRecord
  belongs_to :user
  belongs_to :record
end
