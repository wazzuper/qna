class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:create]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    flash[:notice] = 'Your answer successfully created.' if @answer.save
  end

  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question

    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    else
      flash[:notice] = 'You can\'t delete foreign answer.'
    end
    
    redirect_to @question
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
