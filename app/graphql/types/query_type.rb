module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :users, [UserType], null: false,
                              description: 'Get all users'
    def users
      User.all
    end
    field :user, UserType, null: false,
                           description: 'Get user with id' do
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

    field :records, [RecordType], null: false,
                                  description: 'Get record'
    def records
      Record.all
    end
    field :record, RecordType, null: false,
                               description: 'Get record with id' do
      argument :id, ID, required: true
    end
    def record(id:)
      Record.find(id)
    end

    field :machines, [MachineType], null: false,
                                    description: 'Get machine'
    def machines
      Machine.all
    end
    field :machine, MachineType, null: false,
                                 description: 'Get machine with id' do
      argument :id, ID, required: true
    end
    def machine(id:)
      Machine.find(id)
    end
  end
end
