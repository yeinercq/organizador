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
#
class Task < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user, dependent: :destroy
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :participating_users, reject_if: :all_blank, allow_destroy: true

  before_create :generate_code
  after_create :sent_task_email

  validates :participating_users, presence: true
  validates :name, :description, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :due_date_validation

  aasm column: :status do
    state :pending, initial: true
    state :in_process, :finished

    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
    
  end

  def due_date_validation
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end

  def generate_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def sent_task_email
    return if Rails.env.test?
    Tasks::SendEmailJob.perform_async(self.id)
  end
end
