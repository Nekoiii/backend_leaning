# frozen_string_literal: true

module Types
  class RecordType < Types::BaseObject
    field :id , ID, null: false
    field :title , String, null: false
    field :content , String
    field :type , Types::RecordEnumType

    field :image_url , String


    field :machine, Types::MachineType, null: false
    field :user, Types::UserType, null: false
    
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false



    def machine
      Machine.find(object.machine_id)
    end

    def user
      User.find(object.user_id)
    end



  end
end
