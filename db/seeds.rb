machine1 = Machine.create(name:'machine1')
user1 = User.create(name:'user1')

2.times do 
  Record.create!([
    {
      title:'aaa',
      content:'aaaaaaaaaaa',
      record_type: :hygiene,
      user: user1,
      machine: machine1
    },
    {
      title:'bbb',
      content:'bbbbbbbb',
      record_type: :temperature,
      user: user1,
      machine: machine1
    }
  ])
end


"""
record1 = Record.create(title: 'aaa', content: 'aaaaaaaaaaa')
record2 = Record.create(title: 'bbb', content: 'bbbbbbbb')

user1 = User.create(name:'user1')


machine = Machine.create!
machine.records << record1
machine.records << record2
"""



