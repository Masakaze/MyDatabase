class CreateGameKeyTypes < ActiveRecord::Migration
  def change
    create_table :game_key_types do |t|
      t.string :name_en
      t.string :sign
      t.integer :game_platform_id

      t.timestamps null: false
    end
    add_foreign_key :game_key_types, :game_platforms, column: :game_platform_id
  end
end
