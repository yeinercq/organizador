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

    context 'with params from scratch' do

      let(:owner) { create :user }
      let(:category) { create :category }
      let(:participant_1) { build :participant, :responsible }
      let(:participant_2) { build :participant, :follower }

      subject(:task) do
        described_class.new(
          name: 'Tarea',
          description: 'Desc',
          due_date: Time.now + 5.days,
          category: category,
          owner: owner,
          participating_users: [ participant_1, participant_2 ]
        )
      end
      it { should be_valid }

      context 'after save' do
        before(:each) { task.save }
        it { should be_persisted }

        it 'has a computed code' do
          expect(task.code).to be_present
        end
      end

      context 'with due_date in past' do
        subject { task.tap { |t| t.due_date = Date.today - 1.day } } # modifica la due_date de task
        it { is_expected.to_not be_valid }
      end
    end

    context 'with params from FactoryBot' do
      it "is persisted" do
        expect(task.save).to eq true
      end

      context 'after save' do
        before(:each) { task.save }
        it 'has all associated participants' do
          expect(task.participating_users.count).to eq participants_count
          expect(Participant.count).to eq participants_count
        end
      end

    end
  end
end
