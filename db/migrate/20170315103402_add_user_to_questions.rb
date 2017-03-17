class AddUserToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :questions, :user, foreign_key: true
  end
end
