User.create!(
  name: 'Jalaj',
  email: 'jalaj@mail.com',
  password: '123456',
  password_confirmation: '123456',
  admin: true
)

99.times do |n|
  name = Faker::Name.name
  email = "test#{n + 1}@gmail.com"
  password = '123456'
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do |n|
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |u| u.microposts.create!(content: content) }
end
