module Types
  class MutationType < Types::BaseObject

    field :create_user, mutation: Mutations::CreateUser

    '''
    field :create_user, UserType, null:false,
    description:"Create a new user" do
      argument :name, String, required:true
    end
    def create_user(name:)
      User.create(name:name)
    end
    '''

  end
end
