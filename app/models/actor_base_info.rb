# Rails4での保存方法
=begin
params = ActionController::Parameters.new
params[:actor_base_info] = {:relation_actor_base_id => actor_base.id, :relation_info_id => info.id}
relation = ActorBaseInfo.new(params.require(:actor_base_info).permit(:relation_actor_base_id, :relation_info_id))
=end


class ActorBaseInfo < ActiveRecord::Base

  belongs_to :relation_actor_base, :class_name => "ActorBase", :foreign_key => "relation_actor_base_id"
  belongs_to :relation_info, :class_name => "Info", :foreign_key => "relation_info_id"
end
