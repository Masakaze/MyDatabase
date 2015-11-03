require 'spec_helper'

describe "GameInfos" do

  # 新規作成のページ
  describe "NewPage" do
    create_button = "新規作成"

    it "Wrong info" do
      visit '/game_infos/new'
      fill_in "英語名", with: "Test"

      expect { click_button create_button }.not_to change(GameInfo, :count)
    end
    it "Corret info" do
      visit '/game_infos/new'
      fill_in "日本語名", with: "テスト"
      fill_in "英語名", with: "test"
      
      game_genre = GameGenre.first
      select game_genre.name_jp, from: "game_info_game_genre_ids_"

      game_platform = GamePlatform.first
      select game_platform.name_en, from: "game_info_game_platform_ids_"

      expect { click_button create_button }.to change(GameInfo, :count).by(1)
    end
  end

  # 更新用のページ
  describe "EditPage" do
    update_button = "新規作成"
    register_new_controller_button_base = "新規作成方法登録"

    before do
      @game_info = GameInfo.new(:name_jp => "テスト")
      @game_info.save
    end
=begin
    it "exist register controller button" do
      visit edit_game_info_path(@game_info)
      GamePlatform.all().each { |game_platform|
         expect(find("#register_new_controller_#{game_platform.name_en}")['value']).to eq "[#{game_platform.name_en}]#{register_new_controller_button_base}"
      }
    end
=end
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
