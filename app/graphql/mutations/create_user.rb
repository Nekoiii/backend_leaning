# https://qiita.com/k-penguin-sato/items/07fef2f26fd6339e0e69
class Mutations::CreateUser < Mutations::BaseMutation
  argument :name, String

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(name:)
    user = User.new(name:)

    if user.save
        user:,
        errors: []
    else
        user: nil,
        errors: user.errors.full_messages
    end
  end
end
