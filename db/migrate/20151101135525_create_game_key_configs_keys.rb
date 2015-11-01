class CreateGameKeyConfigsKeys < ActiveRecord::Migration
  def change
    create_table :game_key_configs_keys do |t|
      t.integer :game_key_config_id
      t.integer :game_key_id
    end
  end
end
