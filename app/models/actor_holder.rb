class ActorHolder < ActiveRecord::Base

  belongs_to :actor_base
  has_many :relation_infos, :through => :actor_base
end
