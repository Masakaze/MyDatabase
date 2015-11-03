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
      select game_platform.name_en, from: "game_platform_add"

      expect { click_button create_button }.to change(GameInfo, :count).by(1)
    end
  end

  # 更新用のページ
  describe "EditPage" do
    update_button = "新規作成"
    register_new_controller_button_base = "新規操作方法登録"

    before do
      @game_info = GameInfo.find_or_create_by(:name_jp => "テスト")
      if @game_info.new_record?
        GamePlatform.all().each { |game_platform|
          next if game_platform.id == 1 # 1個だけ登録を余しておく
          @game_info.game_platforms << game_platform
        }
        @game_info.save
      end
    end

    # プラットフォーム一つ追加
    it "add game_platform" do
      visit edit_game_info_path(@game_info)
      game_platform = GamePlatform.find(1)
      select game_platform.name_en, from: "game_platform_add"
      expect { click_button update_button }.to change(@game_info.game_platforms, :count).by(1)
    end

    # 新規登録ゲームの場合はプラットフォームごとに新規登録ボタンが表示される
    it "exist register controller button" do
      visit edit_game_info_path(@game_info)
      @game_info.game_platforms.all().each { |game_platform|
         expect(find("#register_new_controller_#{game_platform.name_en}")['value']).to eq "[#{game_platform.name_en}]#{register_new_controller_button_base}"
      }
    end

    # 操作方法の登録

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
      @game_info = GameInfo.find_or_create_by(name_jp: "テストゲーム")
      @game_info.game_platforms << GamePlatform.find(1) if @game_info.new_record?
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
