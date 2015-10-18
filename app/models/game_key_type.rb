class GameKeyType < ActiveRecord::Base

  belongs_to :game_platform
  has_many :game_keys

  validates :game_platform_id, presence: true
  # name_enとgame_platform_idの組み合わせでuniqueチェック 必要があったらマイグレーションに下記追加
  # add_index :game_key_types, [:name_en, :game_platform_id], :unique => true
  validates :name_en, :uniqueness => {:scope => [:game_platform_id]}
end
