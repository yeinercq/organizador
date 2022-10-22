# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#  code        :string
#  status      :string
#  transitions :hstore           is an Array
#
FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "Tarea #{n}" }
    sequence(:description) { |n| "Descripcion #{n}" }
    due_date { Date.today + 15.days }
    category
    association :owner, factory: :user

    factory :task_with_participants do
      transient  do
        participants_count { 5 }
      end

      after(:build) do |task, evaluator|
        task.participating_users = build_list(
          :participant,
          evaluator.participants_count,
          task: task,
          role: 1
        )
        task.category.save
        task.owner.save
      end
    end
  end
end
