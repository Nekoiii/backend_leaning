# frozen_string_literal: true

# https://qiita.com/k-penguin-sato/items/07fef2f26fd6339e0e69
module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :name, String

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(name:)
      # Style/HashSyntax: Omit the hash value  (→ when using rubocop)
      # ハッシュのキーと値が同じ場合は書かず、異なる (意図のある) 値は明示的に書く
      user = User.new(name:)

      if user.save
        {
          user: nil,
          errors: []
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
