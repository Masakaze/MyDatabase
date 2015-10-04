class GameGenre < ActiveRecord::Base
  attr_accessor :name_jp, :name_en

  has_many :game_infos
end
