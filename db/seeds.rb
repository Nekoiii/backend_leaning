# frozen_string_literal: true

machine1 = Machine.create(name: 'machine1')
user1 = User.create(name: 'user1')

record1 = Record.create(
  title: 'aaa',
  content: 'aaaaaaaaaaa',
  record_type: :hygiene,
  record_status: 'overflow',
  machine: machine1
)

record2 = Record.create(
  title: 'bbb',
  content: 'bbbbbbbb',
  record_type: :temperature,
  record_status: 'resolved',
  machine: machine1
)

UserRecord.create(user: user1, record: record1)
UserRecord.create(user: user1, record: record2)

''"
record1 = Record.create(title: 'aaa', content: 'aaaaaaaaaaa')
record2 = Record.create(title: 'bbb', content: 'bbbbbbbb')

user1 = User.create(name:'user1')


machine = Machine.create!
machine.records << record1
machine.records << record2
"''
