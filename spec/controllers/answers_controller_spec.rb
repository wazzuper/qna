require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user){ create(:user) }
  let(:user2){ create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        #Мы ожидаем, что код выполненный в блоке изменит question.answers на 1 единицу
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js } }.to change(question.answers, :count).by(1)
      end

      it "render create template" do
        #Отображаем вопрос с нашим ответом
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(response).to render_template :create
      end

      it 'this answer belongs to user' do
        #Сверяем answer.user и current_user
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }
        expect(assigns(:answer).user_id).to eq @user.id
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, format: :js } }.to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
       
    context 'true author' do
      sign_in_user

      it 'assigns the requested answer to @answer' do
        patch :update, params: { id: answer, question: question, answer: attributes_for(:answer), format: :js }
        expect(assigns(:answer)).to eq(answer)
      end

      it 'assigns the question' do
        patch :update, params: { id: answer, question: question, answer: attributes_for(:answer), format: :js }
        expect(assigns(:question)).to eq(question)
      end

      it 'changes answer attributes' do
        sign_in user
        patch :update, params: { id: answer, question: question, answer: { body: 'new body' }, format: :js }
        answer.reload
        expect(answer.body).to eq('new body')
      end

      it 'render update template' do
        patch :update, params: { id: answer, question: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'another author' do

      it 'trying to edit foreign answer' do
        sign_in user2
        patch :update, params: { id: answer, question: question, answer: { body: "new body" }, format: :js }
        expect(answer.body).to_not eq "new body"
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'true author delete his answer' do
      sign_in user
      answer
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end

    it 'delete answer by another author' do
      sign_in user2
      expect { delete :destroy, params: { id: answer }, format: :js }.to_not change(Answer, :count)
    end

    it 'redirect to questions' do
      sign_in user
      delete :destroy, params: { id: answer }, format: :js
      expect(response).to render_template :destroy
    end
  end

  describe 'POST #set_best' do

    context 'authenticated user' do

      it 'true author set the best question' do
        sign_in user
        patch :set_best, params: { id: answer, question: question, answer: attributes_for(:answer) }, format: :js
        expect(answer.reload).to be_best
      end

      it 'another author trying to set the best question' do
        sign_in user2
        patch :set_best, params: { id: answer, question: question, answer: attributes_for(:answer) }, format: :js
        expect(answer.reload).to_not be_best
      end

      it 'render set_best template' do
        sign_in user
        patch :set_best, params: { id: answer, question: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :set_best
      end
    end

    context 'non-authenticated user' do

      it 'can\'t set the best answer' do
        patch :set_best, params: { id: answer, question: question, answer: attributes_for(:answer) }, format: :js
        expect(answer.reload.best).not_to eql(true)
      end
    end
  end
end
