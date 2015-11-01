class GameInfosController < ApplicationController
  before_action :set_game_info, only: [:show, :edit, :update, :destroy]

  # GET /game_infos
  # GET /game_infos.json
  def index
    @game_infos = GameInfo.all
  end

  # GET /game_infos/1
  # GET /game_infos/1.json
  def show
  end

  # GET /game_infos/new
  def new
    @game_info = GameInfo.new
  end

  # GET /game_infos/1/edit
  def edit
    @is_register_new_controller_manual = false
  end

  # POST /game_infos
  # POST /game_infos.json
  def create
    @game_info = GameInfo.new(game_info_params)
    @game_info = update_game_genres(params[:game_info])
    @game_info = update_game_platforms(params[:game_info])
    @game_info = update_game_key_configs(params[:game_info])

    respond_to do |format|
      if @game_info.save
        format.html { redirect_to @game_info, notice: 'Game info was successfully created.' }
        format.json { render :show, status: :created, location: @game_info }
      else
        format.html { render :new }
        format.json { render json: @game_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_infos/1
  # PATCH/PUT /game_infos/1.json
  def update
    @game_info = update_game_genres(params[:game_info])
    @game_info = update_game_platforms(params[:game_info])
    @game_info = update_game_key_configs(params[:game_info])

    respond_to do |format|
      if @game_info.save
        format.html { redirect_to @game_info, notice: 'Game info was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_info }
      else
        format.html { render :edit }
        format.json { render json: @game_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_infos/1
  # DELETE /game_infos/1.json
  def destroy
    @game_info.destroy
    respond_to do |format|
      format.html { redirect_to game_infos_url, notice: 'Game info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def switch_by_platform
    @current_platform = params[:platform]
    render
  end

  # 新しい操作方法登録
  def register_new_controller_manual
    @game_info = GameInfo.find(params[:id])
    @game_platform_id = params[:game_platform_id]

#    redirect_to "/game_infos/#{@game_info.id}/edit"
#    render
  end

  # 新規アクション登録フォーム
  def register_new_game_action_form
    render 'register_new_game_action_form'
  end

  def register_new_game_action
    @game_action = GameAction.find_or_create_by(:name_en => params[:name_en], :name_jp => params[:name_jp])
    @is_success = @game_action.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_info
      @game_info = GameInfo.find(params[:id])
    end

    def update_game_genres(genre_params)
      return @game_info if genre_params[:game_genre_ids] == nil

      # 追加
      genre_params[:game_genre_ids].each { |game_genre_id|
        game_genre = GameGenre.find_by(:id => game_genre_id)
        next if game_genre == nil
        next if @game_info.game_genres.include?(game_genre)
        @game_info.game_genres << game_genre
      }

      # 削除
      @game_info.game_genres.each { |game_genre|
        next if genre_params[:game_genre_ids].include?(game_genre.id)
        @game_info.game_genres.delete(game_genre)
      }

      return @game_info
    end

    def update_game_platforms(platform_params)
      return @game_info if platform_params[:game_platform_ids] == nil

      # 追加
      platform_params[:game_platform_ids].each { |game_platform_id|
        game_platform = GamePlatform.find_by(:id => game_platform_id)
        next if game_platform == nil
        next if @game_info.game_platforms.include?(game_platform)
        @game_info.game_platforms << game_platform
      }

      # 削除
      @game_info.game_platforms.each { |game_platform|
        next if platform_params[:game_platform_ids].include?(game_platform.id)
        @game_info.game_platforms.delete(game_platform)
      }

      return @game_info
    end

    def update_game_key_configs(key_config_params)
      return @game_info if key_config_params[:game_key_configs] == nil

      key_config_params[:game_key_configs].each { |game_key_config_info|
        game_platform_id = game_key_config_info.delete(:game_platform_id)

        game_key_config = GameKeyConfig.find_or_create_by(:game_platform_id => game_platform_id, :game_info_id => @game_info.id)

        game_key_config_info.each { |key, value|
          next if value == ""

          game_key = GameKey.find_or_create_by(:game_key_type_id => key.to_i, :game_action_id => value.to_i)
          game_key.save if game_key.new_record?

          # 同じキータイプの場合は入れ替え
          game_key_config.game_keys.each_with_index { |current_game_key, idx|
            # ボタンタイプが違う場合は特になにもしない
            next if current_game_key.game_key_type_id != game_key.game_key_type_id
            game_key_configs.game_keys[idx] = game_key
          }
        }

        # 新規KeyConfigの場合は追加
        if game_key_config.new_record?
          @game_info.key_configs << game_key_config
        end
      }

      return @game_info
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_info_params
      params.require(:game_info).permit(:name_jp, :name_en, :game_genre_ids => [], :game_platform_ids => [], :game_key_configs => [])
    end
end
