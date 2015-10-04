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
  end

  # POST /game_infos
  # POST /game_infos.json
  def create
    @game_info = GameInfo.new(game_info_params)

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
    respond_to do |format|
      if @game_info.update(game_info_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_info
      @game_info = GameInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_info_params
      params.require(:game_info).permit(:name_jp, :name_en, :game_genre_id)
    end
end
