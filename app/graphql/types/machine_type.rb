# frozen_string_literal: true

module Types
  class MachineType < Types::BaseObject
    field :id , ID, null: false
    field :record_ids, [ID]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
