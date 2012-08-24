require 'faker'

FactoryGirl.define do
  factory :task do
    title {Faker::Lorem.sentence}
    due_date { rand(2.years).ago }
    priority { Task.priority.values.sample }
    completed { [true, false].sample }
    user

    factory :invalid_task, class: Task do
      title nil
    end
  end
end
