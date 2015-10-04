class GameGenresController < ApplicationController
  before_action :set_game_genre, only: [:show, :edit, :update, :destroy]

  # GET /game_genres
  # GET /game_genres.json
  def index
    @game_genres = GameGenre.all
  end

  # GET /game_genres/1
  # GET /game_genres/1.json
  def show
  end

  # GET /game_genres/new
  def new
    @game_genre = GameGenre.new
  end

  # GET /game_genres/1/edit
  def edit
  end

  # POST /game_genres
  # POST /game_genres.json
  def create
    @game_genre = GameGenre.new(game_genre_params)

    respond_to do |format|
      if @game_genre.save
        format.html { redirect_to @game_genre, notice: 'Game genre was successfully created.' }
        format.json { render :show, status: :created, location: @game_genre }
      else
        format.html { render :new }
        format.json { render json: @game_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_genres/1
  # PATCH/PUT /game_genres/1.json
  def update
    respond_to do |format|
      if @game_genre.update(game_genre_params)
        format.html { redirect_to @game_genre, notice: 'Game genre was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_genre }
      else
        format.html { render :edit }
        format.json { render json: @game_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_genres/1
  # DELETE /game_genres/1.json
  def destroy
    @game_genre.destroy
    respond_to do |format|
      format.html { redirect_to game_genres_url, notice: 'Game genre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_genre
      @game_genre = GameGenre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_genre_params
      params.require(:game_genre).permit(:name_jp, :name_en)
    end
end
