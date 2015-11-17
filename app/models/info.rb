class Info < ActiveRecord::Base
  has_many :actor_base_info_relations, :class_name => "ActorBaseInfo", :foreign_key => "relation_info_id"#, :autosave => true
  has_many :relation_actor_bases, :class_name => "ActorBase", :through => :actor_base_info_relations, :source => "relation_actor_base"
end
