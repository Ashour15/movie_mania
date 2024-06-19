class AddUniqueIndexToActorsName < ActiveRecord::Migration[6.1]
  def change
    add_index :actors, :name, unique: true
  end
end
