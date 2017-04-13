require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  describe '#set_best' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }
    let(:answer2) { create(:answer, question: question, user: user) }

    it 'answer best is true' do
      answer
      answer.set_best

      expect(answer).to be_best
    end

    it 'only one answer is the best' do
      answer
      answer.set_best
      answer2
      answer2.set_best

      expect(answer.reload).to_not be_best
      expect(answer2.reload).to be_best
    end
  end

  describe 'vote' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, question: question, user: user) }

    it '#vote_up' do
      answer.vote_up(user2)
      expect(answer.votes_summary).to eq(1)
    end

    it '#vote_down' do
      answer.vote_down(user2)
      expect(answer.votes_summary).to eq (-1)
    end

    it '#vote_cancel' do
      answer.vote_cancel(user2)
      expect(answer.votes_summary).to eq (0)
    end

    it '#vote_summary' do
      answer.vote_up(user3)
      answer.vote_up(user2)
      expect(answer.votes_summary).to eq(2)
    end
    it '#voted?' do
      answer.vote_up(user2)
      expect(answer.voted?(user2)).to eq(true)
    end
  end
end
