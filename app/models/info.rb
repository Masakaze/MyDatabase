class Info < ActiveRecord::Base
  has_many :actor_base_info_relations, :class_name => "ActorBaseInfo", :foreign_key => "relation_info_id"
  has_many :relation_actor_bases, :through => :actor_base_info_relations
end
