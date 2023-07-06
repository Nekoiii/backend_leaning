machine1 = Machine.create!
user1 = User.create(name:'user1')
record = Record.create!([
  {
    title:'aaa',
    content:'aaaaaaaaaaa',
    type:'"HYGIENE"',
    user: user1,
    machine: machine1
  },
  {
    title:'bbb',
    content:'bbbbbbbb',
    type:'TEMPERATURE',
    user: user1,
    machine: machine1
  }
])



"""
record1 = Record.create(title: 'aaa', content: 'aaaaaaaaaaa')
record2 = Record.create(title: 'bbb', content: 'bbbbbbbb')

user1 = User.create(name:'user1')


machine = Machine.create!
machine.records << record1
machine.records << record2
"""



