# по примеру из лекции
module Voted
  extend ActiveSupport::Concern
  included do
    before_action :set_votable, only: [:vote_up, :vote_down, :vote_cancel]
  end

  def vote_up
    if !current_user.author_of?(@votable) && !@votable.voted?(current_user)
      @votable.vote_up(current_user)
      render json: { votes_count: @votable.votes_summary, id: @votable.id, type: controller_name.singularize }
    end
  end

  def vote_down
    if !current_user.author_of?(@votable) && !@votable.voted?(current_user)
      @votable.vote_down(current_user)
      render json: { votes_count: @votable.votes_summary, id: @votable.id,type: controller_name.singularize }
    end
  end

  def vote_cancel
    if !@votable.votes(current_user).nil?
      @votable.vote_cancel(current_user)
      render json: { votes_count: @votable.votes_summary, id: @votable.id, type: controller_name.singularize }
    end
  end

  private

  # определяем в контексте какой модели мы находимся
  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end