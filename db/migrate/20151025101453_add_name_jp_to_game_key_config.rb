class AddNameJpToGameKeyConfig < ActiveRecord::Migration
  def change
    add_column :game_key_configs, :name_jp, :string
  end
end
