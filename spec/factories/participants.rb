FactoryBot.define do
  factory :participant do

    association :user

    trait :responsible do
      role { 1 }
    end

    trait :follower do
      role { 2 }
    end

    after(:build) do |participant, _|
      participant.user.save
    end
  end
end
