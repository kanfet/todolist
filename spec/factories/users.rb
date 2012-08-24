require 'faker'

FactoryGirl.define do
  factory :user do
    username {Faker::Internet.user_name}
    password {Faker::Internet.email}
    password_confirmation {password}
  end

  factory :invalid_user, class: User do
    username {Faker::Internet.user_name}
    password {Faker::Internet.email}
    password_confirmation ""
  end
end
