# frozen_string_literal: true

module Types
  class RecordType < Types::BaseObject
    field :id , ID, null: false
    field :title , String, null: false
    field :content , String
    field :record_type , Types::RecordEnumType

    field :image_url , String

    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false


    '''
    The methods defined here can only be called in graphql, 
    and cannot be directly used in the ActiveRecord model !!!!
    So if use <%=record.full_title%> in index.html.erb, 
    it will report an error !!!!
    '''
    field :full_title, String
    def full_title
     "#{object.title} - #{object.machine.name}"
    end


    def machine
      Machine.find(object.machine_id)
    end

    def user
      User.find(object.user_id)
    end



  end
end
