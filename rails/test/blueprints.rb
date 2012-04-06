require 'machinist/active_record'

User.blueprint do
  login                 { "user_#{sn}" }
  email                 { "#{sn}@gmail.com" }
  password              { "password" }
  password_confirmation { "password" }
end