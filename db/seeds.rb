User.create(
    name: Faker::Name,
    email: Faker::Internet.email,
    password: 'password', 
    password_confirmation: 'password'
)