require 'spec_helper'

describe "GameInfos" do
=begin
  describe "GET /game_infos" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get game_infos_index_path
      response.status.should be(200)
    end
  end
=end

  describe "TopPage" do
    it "TopPage's content should be" do
      visit '/game_infos'
      expect(page).to have_content("ゲームデータベース")
      expect(page).to have_title("GameDataBase")
    end
  end
end
