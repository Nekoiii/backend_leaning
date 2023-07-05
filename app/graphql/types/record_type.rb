# frozen_string_literal: true

module Types
  class RecordType < Types::BaseObject
    field :id , ID, null: false
    field :title , String, null: false
    field :content , String
    field :type , RecordEnumType
    field :machine , String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
