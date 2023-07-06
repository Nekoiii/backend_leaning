# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id , ID, null: false
    field :name , String, null: false
    field :records , [Types::RecordType], null:true
    
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    '''
    field :records, [Types::RecordType], null: true do
      resolve ->(user, args, ctx) {
        user.records
      }
    end
    '''


  end
end
