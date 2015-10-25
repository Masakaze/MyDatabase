class GameKey < ActiveRecord::Base
  belongs_to :game_key_type
  belongs_to :game_action
  has_and_belongs_to_many :game_key_configs

  validates :game_key_type_id, presence: true
  validates :game_action_id, presence: true
end
