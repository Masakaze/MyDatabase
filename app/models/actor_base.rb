class ActorBase < ActiveRecord::Base
  has_many :actor_base_info_relations, :class_name => "ActorBaseInfo", :foreign_key => "relation_actor_base_id"
  has_many :relation_infos, :class_name => "Info", :through => :actor_base_info_relations, :source => "relation_info"
  has_one :actor_holder
end
