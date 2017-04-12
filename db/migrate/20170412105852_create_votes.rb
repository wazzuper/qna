class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.integer :rating
      t.integer :votable_id
      t.string :votable_type
      t.index [:votable_id, :votable_type]
      t.timestamps
    end
  end
end
