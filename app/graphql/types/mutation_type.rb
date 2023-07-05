module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end

    field :record, RecordType, null: false,
      description: "Get record"
    def record
      "Get record"
    end




  end
end
