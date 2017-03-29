require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }

  it { should validate_presence_of :body }

  describe '#set_best'
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  it 'answer best is true' do
    answer.set_best

    expect(answer).to be_best
  end
end
