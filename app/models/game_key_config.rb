class GameKeyConfig < ActiveRecord::Base

  validates :game_info_id, presence: true
  validates :game_platform_id, presence: true

  belongs_to :game_info
  belongs_to :game_platform
end
