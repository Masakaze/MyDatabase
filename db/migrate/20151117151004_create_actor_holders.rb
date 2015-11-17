class CreateActorHolders < ActiveRecord::Migration
  def change
    create_table :actor_holders do |t|
      t.integer :actor_base_id

      t.timestamps null: false
    end
  end
end
