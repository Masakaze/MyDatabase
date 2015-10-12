class GameInfo < ActiveRecord::Base
#  attr_accessible :name_jp, :name_en
#  attr_accessible :game_genre_id

  validates :name_jp, presence: true, length: { maximum: 30 }

  has_and_belongs_to_many :game_genres
  has_and_belongs_to_many :game_platforms
end
