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
    @game_key_config = GameKeyConfig.new(:game_info_id => 1, :game_platform_id => 1, :name_jp => "テスト")
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

  describe "when GameKeyConfigs has duplicate parameter(game_info_id, game_platform_id, name_jp)" do
    before do
      duplicate_info = {:game_info_id => @dummy_game_info.id, :game_platform_id => @dummy_game_platform.id, :name_jp => "重複データ"}
      first_save_data = GameKeyConfig.find_or_create_by(duplicate_info)
      @game_key_config = GameKeyConfig.new(duplicate_info)
    end

    it { should_not be_valid }
  end

end
