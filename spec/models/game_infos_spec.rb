require 'spec_helper'

describe "GameInfos" do
end

# GameKeyType
describe "Game Key Type" do
  before do
    @game_key_type = GameKeyType.new(:name_en => "Test", :game_platform_id => 1)
    @game_key_type_valid = @game_key_type.dup()
  end
  subject { @game_key_type }
  it { should be_valid }

  describe "when game_platform_id equal nil" do
    before do
      @game_key_type = @game_key_type_valid.dup()
      @game_key_type.game_platform_id = nil
    end
    it { should_not be_valid }
  end

  describe "when game_platform_id and name_en is duplicate" do
    before do
      info = {:name_en => "FirstData", :game_platform_id => 1}
      first_save_data = GameKeyType.find_or_create_by(:name_en => "FirstData", :game_platform_id => 1)
      @game_key_type = GameKeyType.new(info)
    end

    it { should_not be_valid }
  end
end

# GameKey
describe "GameKey" do
  before do
    @game_key = GameKey.new(:game_key_type_id => 1, :game_action_id => 1)
    @game_key_valid = @game_key.dup()
  end
  subject { @game_key }
  it { should be_valid }

  describe "when GameKey game_key_type_id equal nil" do
    before do
      @game_key = @game_key_valid.dup()
      @game_key.game_key_type_id = nil
    end
    it { should_not be_valid }
  end

  describe "when GameKey game_action_id equal nil" do
    before do
      @game_key = @game_key_valid.dup()
      @game_key.game_action_id = nil
    end
    it { should_not be_valid }
  end
end

describe "GameKeyConfigs" do
  before do
    @dummy_game_info = GameInfo.find_or_create_by(:name_en => "DummyGameInfo", :name_jp => "ダミー")
    @dummy_game_platform = GamePlatform.find_or_create_by(:name_en => "PS4")
    if @dummy_game_info.new_record?
      @dummy_game_info.game_platforms << @dummy_game_platform 
      @dummy_game_info.save
    end
    @info = { :game_info_id => @dummy_game_info.id, :game_platform_id => @dummy_game_platform.id }
    @game_key_config = GameKeyConfig.new(@info.merge(:name_jp => "テスト"))
    @game_key_config_correct = @game_key_config.dup
  end
  subject { @game_key_config }
  it { should be_valid }

  describe "when GameKeyConfigs game_info_id equal nil" do
    before do
      @game_key_config = @game_key_config_correct.dup()
      @game_key_config.game_info_id = nil
    end

    it { should_not be_valid }
  end

  describe "when GameKeyConfigs game_platform_id equal nil" do
    before do
      @game_key_config = @game_key_config_correct.dup()
      @game_key_config.game_platform_id = nil
    end

    it { should_not be_valid }
  end

  describe "when GameKeyConfigs can have duplicate paramter" do
    before do
      duplicate_info1 = @info.merge(:name_jp => "重複OKデータ1")
      first_save_data = GameKeyConfig.find_or_create_by(duplicate_info1)
      duplicate_info2 = @info.merge(:name_jp => "重複OKデータ2")
      @game_key_config = GameKeyConfig.new(duplicate_info2)
    end

    it { should be_valid }
  end

  describe "when GameKeyConfigs should'nt have duplicate parameter(game_info_id, game_platform_id, name_jp)" do
    before do
      duplicate_info = @info.merge(:name_jp => "重複データ")
      first_save_data = GameKeyConfig.find_or_create_by(duplicate_info)
      @game_key_config = GameKeyConfig.new(duplicate_info)
    end

    it { should_not be_valid }
  end

  # GameInfoがsaveされた時にGameKeyConfigがsaveされる依存関係の確認
  it "when game_key_config saved with game_info" do
    game_info = GameInfo.new(:name_jp => "ゲームキーコンフィグ確認", :name_en => "GameKeyConfigConfirm")
    game_info.game_platforms << GamePlatform.find(1)
    game_info.save
    @game_key_config = GameKeyConfig.new(:game_info_id => game_info.id, :game_platform_id => 1)
    @game_key_config.save
    game_key = GameKey.new(:game_key_type_id => 1, :game_action_id => 1)
    game_key.save
    @game_key_config.game_keys << game_key # 別のテーブルの値が変更されているだけ
    #puts @game_key_config.changes # {}
    game_info.game_key_configs << @game_key_config

    @game_key_config.game_platform_id = 2
    expect(@game_key_config.changed?).to eq true
    #puts @game_key_config.changes # {:game_platform_id => [1,2] }
    game_info.save

    expect(@game_key_config.changed?).to eq false
  end

end
