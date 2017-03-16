require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'author_of?' do
    let(:user){ create(:user) }

    it 'true author' do
      question = create(:question, user: user)
      expect(user).to be_author_of(question)
    end

    it 'false author' do
      user2 = create(:user)
      question = create(:question, user: user2)
      expect(user).to_not be_author_of(question)
    end
  end
end
