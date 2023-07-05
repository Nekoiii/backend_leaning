"""record = Record.create!([
  {
    title:'aaa',
    content:'aaaaaaaaaaa'
  },
  {
    title:'bbb',
    content:'bbbbbbbb'
  }
])
machine = Machine.create!([
  {
    record_ids:[]
  }
])"""


record1 = Record.create(title: 'aaa', content: 'aaaaaaaaaaa')
record2 = Record.create(title: 'bbb', content: 'bbbbbbbb')

machine = Machine.create!
machine.records << record1
machine.records << record2




