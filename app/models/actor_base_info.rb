class ActorBaseInfo < ActiveRecord::Base

  belongs_to :relation_actor_base, :class_name => "ActorBase", :foreign_key => "relation_info_id"
  belongs_to :relation_info, :class_name => "Info", :foreign_key => "relation_actor_base_id"
end
