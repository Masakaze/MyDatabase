require 'spec_helper'

describe "GameInfos" do

  # 新規作成のページ
  describe "NewPage" do
    it "NewPage should be" do
      visit '/game_infos/new'
      fill_in "日本語名", with: "テスト"
      fill_in "英語名", with: "test"
      
      game_genre = GameGenre.first
      select game_genre.name_jp, from: "game_info_game_genre_ids_"

      game_platform = GamePlatform.first
      select game_platform.name_en, from: "game_info_game_platform_ids_"

      expect { click_button "新規作成" }.to change(GameInfo, :count).by(1)
    end
  end

  # 更新用のページ
  describe "EditPage" do
  end

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
