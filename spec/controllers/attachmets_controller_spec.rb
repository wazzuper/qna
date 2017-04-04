require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:attachment) { create(:attachment, attachable: question) }

  describe 'DELETE #destroy' do

    context 'true author' do

      it 'delete attachment' do
        sign_in user
        expect { delete :destroy, params: { id: attachment }, format: :js }.to change(Attachment, :count).by(-1)
      end

      it 'render destroy template' do
        sign_in user
        delete :destroy, params: { id: attachment }, format: :js
        expect(response).to render_template :destroy
      end
    end

    it 'delete attachment by foreign author' do
      sign_in user2
      expect { delete :destroy, params: { id: attachment}, format: :js }.to_not change(Attachment, :count)
    end
  end
end