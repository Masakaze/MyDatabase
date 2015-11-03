class GameKeyConfig < ActiveRecord::Base

  validates :game_info_id, presence: true
  validates :game_platform_id, presence: true
  validates :name_jp, :uniqueness => {:scope => [:game_platform_id, :game_info_id]}

  belongs_to :game_info#, :autosave => true
  belongs_to :game_platform
  has_and_belongs_to_many :game_keys
end
