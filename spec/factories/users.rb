require 'faker'

FactoryGirl.define do
  factory :user do
    username {Faker::Internet.user_name}
    password {Faker::Internet.email}
    password_confirmation {password}
  end
end
