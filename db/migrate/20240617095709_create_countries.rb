class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :countries, :name, unique: true
  end
end
