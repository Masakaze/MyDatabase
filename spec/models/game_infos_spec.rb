require 'spec_helper'

describe "GameInfos" do
end

# GameKeyType
describe "Game Key Type" do
  before { @game_key_type = GameKeyType.new(:name_en => "Test", :game_platform_id => 1) }
  subject { @game_key_type }
  it { should be_valid }

  describe "when game_platform_id equal nil" do
    before { @game_key_type.game_platform_id = nil }
    it { should_not be_valid }
  end
end

# GameKey
describe "GameKey" do
  before { @game_key = GameKey.new(:game_key_type_id => 1, :game_action_id => 1) }
  subject { @game_key }
  it { should be_valid }

  describe "when GameKey game_key_type_id equal nil" do
    before { @game_key.game_key_type_id = nil }
    it { should_not be_valid }
  end

  describe "when GameKey game_action_id equal nil" do
    before do
      @game_key.game_key_type_id = 1
      @game_key.game_action_id = nil
    end
    it { should_not be_valid }
  end
end
