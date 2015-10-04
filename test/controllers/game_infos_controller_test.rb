require 'test_helper'

class GameInfosControllerTest < ActionController::TestCase
  setup do
    @game_info = game_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_info" do
    assert_difference('GameInfo.count') do
      post :create, game_info: { name_en: @game_info.name_en, name_jp: @game_info.name_jp }
    end

    assert_redirected_to game_info_path(assigns(:game_info))
  end

  test "should show game_info" do
    get :show, id: @game_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_info
    assert_response :success
  end

  test "should update game_info" do
    patch :update, id: @game_info, game_info: { name_en: @game_info.name_en, name_jp: @game_info.name_jp }
    assert_redirected_to game_info_path(assigns(:game_info))
  end

  test "should destroy game_info" do
    assert_difference('GameInfo.count', -1) do
      delete :destroy, id: @game_info
    end

    assert_redirected_to game_infos_path
  end
end
