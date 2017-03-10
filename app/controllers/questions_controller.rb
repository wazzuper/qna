class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :load_question, only: [:show]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)

    if @question.save
      redirect_to @question, notice: 'Your question is successfully created.'
    else
      render :new
    end
  end

  #def edit
  #end

  #def update
    #if @question.update(question_params)
      #redirect_to @question
    #else
      #render :edit
    #end
  #end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
