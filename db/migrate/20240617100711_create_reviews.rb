class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :stars
      t.text :review

      t.timestamps
    end
    add_index :reviews, [:user_id, :movie_id], unique: true
  end
end
