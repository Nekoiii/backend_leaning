# frozen_string_literal: true

UserRecord.destroy_all
Record.destroy_all
User.destroy_all
Machine.destroy_all

machines = []
5.times do |i|
  machines << Machine.create!(name: "Machine #{i}")
end

users=[]
20.times do |i|
  name  = "User #{i}"
  email = "user-#{i}@mail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

records = []
30.times do |i|
  records << Record.create!(
    title: "Record #{i}", 
    content: "Content for record #{i}",
    machine: [machines.sample, nil].sample,
    record_type: Types::RecordEnumType::RECORD_TYPES.keys.sample,
    record_status: Types::RecordStatusEnumType::RECORD_STATUS.keys.sample
  )
end

"""
'user.records << ...' will act as 
'UserRecord.create(user: ...., record: ....)'
"""
users.each do |user|
  user.records << records.sample(rand(1..5))
end

admin_user = User.create(
  name: 'a',
  email:'a@a.a',
  password:'aaaaaa',
  password_confirmation:'aaaaaa',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)




