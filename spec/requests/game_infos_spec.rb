require 'spec_helper'

describe "GameInfos" do
  describe "TopPage" do
    it "TopPage's content should be" do
      visit '/game_infos'
      expect(page).to have_content("ゲームデータベース")
      expect(page).to have_title("GameDataBase")
    end
  end

  describe "GameInfoRegister" do
    before do
      @game_info = GameInfo.new(name_jp: "テストゲーム", name_en: "testgame2")
    end

    subject { @game_info}
    it { should respond_to(:name_jp) }

    it { should be_valid }

    describe "when name_jp is not presence" do
      before { @game_info.name_jp = "" }
      it { should_not be_valid }
    end

    describe "when name_jp is too long" do
      before { @game_info.name_jp = "A"*31 }
      it { should_not be_valid }
    end

    describe "when name_en include kana character" do
      before { @game_info.name_en = "あ" }
      it { should_not be_valid }
    end
  end
end
