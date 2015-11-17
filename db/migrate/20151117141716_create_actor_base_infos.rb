class CreateActorBaseInfos < ActiveRecord::Migration
  def change
    create_table :actor_base_infos do |t|
      t.integer :relation_actor_base_id
      t.integer :relation_info_id

      t.timestamps null: false
    end
  end
end
