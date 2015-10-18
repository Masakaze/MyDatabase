class CreateGameKeys < ActiveRecord::Migration
  def change
    create_table :game_keys do |t|
      t.integer :game_key_type_id

      t.timestamps null: false
    end
    add_foreign_key :game_keys, :game_key_types, column: :game_key_type_id
  end
end
