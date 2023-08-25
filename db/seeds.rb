# frozen_string_literal: true

UserRecord.destroy_all
Record.destroy_all
User.destroy_all
Machine.destroy_all

machines = []
5.times do |i|
  machines << Machine.create!(name: "Machine #{i+1}")
end

users=[]
20.times do |i|
  name  = "User #{i+1}"
  email = "user-#{i+1}@mail.com"
  password = "password"
  user=User.create!(name:  name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  users << user
end

records = []
30.times do |i|
  records << Record.create!(
    title: "Record #{i+1}", 
    content: "Content for record #{i+1}",
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
  rand(1..5).times do 
    user.records << records.sample
  end
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
admin_user.records << records.sample



