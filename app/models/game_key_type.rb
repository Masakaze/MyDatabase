class GameKeyType < ActiveRecord::Base

  belongs_to :game_platform
  has_many :game_keys

  validates :game_platform_id, presence: true
end
