require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  describe 'vote' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let(:question) { create(:question, user: user) }

    it '#vote_up' do
      question.vote_up(user2)
      expect(question.votes_summary).to eq(1)
    end

    it '#vote_down' do
      question.vote_down(user2)
      expect(question.votes_summary).to eq (-1)
    end

    it '#vote_cancel' do
      question.vote_cancel(user2)
      expect(question.votes_summary).to eq (0)
    end

    it '#vote_summary' do
      question.vote_up(user3)
      question.vote_up(user2)
      expect(question.votes_summary).to eq(2)
    end
    it '#voted?' do
      question.vote_up(user2)
      expect(question.voted?(user2)).to eq(true)
    end
  end
end