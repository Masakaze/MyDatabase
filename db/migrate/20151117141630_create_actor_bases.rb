class CreateActorBases < ActiveRecord::Migration
  def change
    create_table :actor_bases do |t|

      t.timestamps null: false
    end
  end
end
