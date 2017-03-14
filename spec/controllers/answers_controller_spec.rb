require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question_id: question.id) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        #Мы ожидаем, что код выполненный в блоке изменит question.answers на 1 единицу
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end

      it "render question" do
        #Отображаем вопрос с нашим ответом
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question } }.to_not change(Answer, :count)
      end
    end
  end
end
