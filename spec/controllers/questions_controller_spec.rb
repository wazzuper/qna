require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    #С помощью метода let мы выполняем код до тех пор, пока не вызовем его (15 строка)
    #Один раз выполнившись, метод let сохраняет возвращенное значение
    let(:questions) { create_list(:question, 2) }

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
      expect(assigns(:question)).to eq(question)
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

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  #describe 'GET #edit' do
    #sign_in_user
    #before { get :edit, params: { id: question } }

    #it 'assigns the requested question to @question' do
      #Сравниваем переменную question с созданным question
      #expect(assigns(:question)).to eq(question)
    #end

    #it 'renders edit view' do
      #expect(response).to render_template :edit
    #end
  #end

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

  #describe 'PATCH #update' do
    #sign_in_user
    #context 'valid attributes' do
      #it 'assigns the requested question to @question' do
        #Сравниваем переменную question с созданным question
        #patch :update, params: { id: question, question: attributes_for(:question) }
        #expect(assigns(:question)).to eq(question)
      #end

      #it 'changes question attributes' do
        #patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }
        #question.reload
        #expect(question.title).to eq('new title')
        #expect(question.body).to eq('new body')
      #end

      #it 'redirects to the updated question' do
        #patch :update, params: { id: question, question: attributes_for(:question) }
        #expect(response).to redirect_to question
      #end
    #end

    #context 'invalid attributes' do
      #before { patch :update, params: { id: question, question: { title: 'new title', body: nil } } }

      #it 'does not change question attributes' do
        #question.reload
        #expect(question.title).to eq('MyString')
        #expect(question.body).to eq('MyText')
      #end

      #it 're-renders edit view' do
        #expect(response).to render_template :edit
      #end
    #end
  #end
end
