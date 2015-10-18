class GameKeyType < ActiveRecord::Base

  belongs_to :game_platform

  validates :game_platform_id, presence: true
end
