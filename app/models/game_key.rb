class GameKey < ActiveRecord::Base
  belongs_to :game_key_type

  validates :game_key_type_id, presence: true
end
