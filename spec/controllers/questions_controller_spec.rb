require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    #С помощью метода let мы выполняем код до тех пор, пока не вызовем его (15 строка)
    #Один раз выполнившись, метод let сохраняет возвращенное значение
    let(:questions) { create_list(:question, 2) }

    before do
      #Делаем запрос
      get :index
    end

    it 'populates an array of all questions' do
      #Сверяем @questions и созданные в бд два вопроса
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      #Ожидаем, что наш ответ от контроллера такой же, как шаблон index
      expect(response).to render_template :index
    end
  end
end
