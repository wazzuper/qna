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
end
