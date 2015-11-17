class ActorBase < ActiveRecord::Base
  has_many :actor_base_info_relations, :class_name => "ActorBaseInfo", :foreign_key => "relation_actor_base_id"
  has_many :relation_infos, :through => :actor_base_info_relations
end
