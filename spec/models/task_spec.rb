require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:participants_count) { 4 }
  subject(:task) { build(:task_with_participants, participants_count: participants_count) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:participating_users) }
    it { should validate_presence_of(:description) }
  end

  describe "associations" do
    it { should have_many(:participating_users) }
    it { should have_many(:participants) }
    it { should have_many(:notes) }
    it { should belong_to(:category) }
    it { should belong_to(:owner) }
  end

  describe '#save' do

    it "is persisted" do
      expect(task.save).to eq true
    end

    context 'after save' do
      before(:each) { task.save }
      it 'has all associatd participants' do
        expect(task.participating_users.count).to eq participants_count
        expect(Participant.count).to eq participants_count
      end
    end
  end
end
