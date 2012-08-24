require 'faker'

FactoryGirl.define do
  factory :task do
    title {Faker::Lorem.words(3)}
    due_date { rand(2.years).ago }
    priority { Task.priority.values.sample }
    completed { [true, false].sample }
    user
  end
end
