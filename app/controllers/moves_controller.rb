class MovesController < ApplicationController
  # GET /moves
  # GET /moves.json
  before_filter :load_game
  load_and_authorize_resource
  def index
    @moves = @game.moves.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @moves }
    end
  end

  # GET /moves/1
  # GET /moves/1.json
  def show
    @move = @game.moves.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @move }
    end
  end

  # GET /moves/new
  # GET /moves/new.json
  def new
    @move = @game.moves.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @move }
    end
  end

  # GET /moves/1/edit
  def edit
    @move = @game.moves.find(params[:id])
  end

  # POST /moves
  # POST /moves.json
  def create
    @move = @game.moves.new(params[:move])

    respond_to do |format|
      if @move.save
        format.html { redirect_to @game, @move], notice: 'Move was successfully created.' }
        format.json { render json: @move, status: :created, location: @move }
      else
        format.html { render action: "new" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /moves/1
  # PUT /moves/1.json
  def update
    @move = @parent.moves.find(params[:id])

    respond_to do |format|
      if @move.update_attributes(params[:move])
        format.html { redirect_to [@game, @move], notice: 'Move was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moves/1
  # DELETE /moves/1.json
  def destroy
    @move = @parent.moves.find(params[:id])
    @move.destroy

    respond_to do |format|
      format.html { redirect_to moves_url }
      format.json { head :no_content }
    end
  end

  def load_game
    @game = Game.find(params[:game_id])
  end
end
