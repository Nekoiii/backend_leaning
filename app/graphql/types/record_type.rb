# frozen_string_literal: true

module Types
  class RecordType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :content, String
    field :record_type, Types::RecordEnumType
    field :record_status, Types::RecordStatusEnumType

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :machine, Types::MachineType
    def machine
      object.machine
    end

    field :users, [Types::UserType]
    def users
      object.users
    end
    field :full_title, String
    def full_title
      "#{object.title} - #{object.machine.name}"
    end
  end
end
