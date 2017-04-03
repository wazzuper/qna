require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user){ create(:user) }
  let(:user2){ create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET #index' do
    #С помощью метода let мы выполняем код до тех пор, пока не вызовем его
    #Один раз выполнившись, метод let сохраняет возвращенное значение
    let(:questions) { create_list(:question, 2, user: user) }

    #Делаем запрос перед каждым it
    before { get :index }

    it 'populates an array of all questions' do
      #Сверяем @questions и созданные в бд два вопроса
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      #Ожидаем, что наш ответ от контроллера такой же, как шаблон index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      #Сравниваем переменную question с созданным question
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      #Проверяем значение в @question что это вновь созданный экземпляр класса Question
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'build new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, params: { id: question } }

    it 'assigns the requested question to @question' do
      #Сравниваем переменную question с созданным question
      expect(assigns(:question)).to eq(question)
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    #Если атрибуты валидные
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        #Мы ожидаем, что код выполненный в блоке изменит Question.count на 1 единицу
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(assigns(:question).user_id).to eq @user.id
      end
    end

    #Если атрибуты не валидные
    context 'with invalid attributes' do
      it 'does not save the question' do
        #Мы ожидаем, что код выполненный в блоке не изменит Question.count
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    context 'true author' do
      sign_in_user

      it 'assigns the requested question to @question' do
        #Сравниваем переменную question с созданным question
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to eq(question)
      end

      it 'changes question attributes' do
        sign_in user
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload
        expect(question.title).to eq('new title')
        expect(question.body).to eq('new body')
      end

      it 'render update template' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'another author' do

      it 'trying to edit foreign question' do
        sign_in user2
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        expect(question.title).to_not eq('new title')
        expect(question.body).to_not eq('new body')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    context 'true author' do
      it 'deletes question' do
        sign_in user
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirect to index view' do
        sign_in user
        delete :destroy, params: { id: question }
        expect(response).to redirect_to root_path
      end
    end

    context 'another author' do
      it 'delete question by another author' do
        sign_in user2
        question
        expect { delete :destroy, params: { id: question} }.to_not change(Question, :count)
      end
    end
  end
end
