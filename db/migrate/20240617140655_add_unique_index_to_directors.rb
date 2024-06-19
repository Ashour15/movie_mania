class AddUniqueIndexToDirectors < ActiveRecord::Migration[6.1]
  def change
    add_index :directors, :name, unique: true
  end
end
