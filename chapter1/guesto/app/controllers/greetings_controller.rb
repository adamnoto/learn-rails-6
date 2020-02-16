class GreetingsController < ApplicationController
  before_action :set_greeting, only: [:show, :edit, :update, :destroy]

  # GET /greetings
  # GET /greetings.json
  def index
    @greetings = Greeting.all.order(created_at: :desc)
  end

  # GET /greetings/1
  # GET /greetings/1.json
  def show
  end

  # GET /greetings/new
  def new
    @greeting = Greeting.new
  end

  # GET /greetings/1/edit
  def edit
  end

  # POST /greetings
  # POST /greetings.json
  def create
    @greeting = Greeting.new(greeting_params)

    respond_to do |format|
      if @greeting.save
        format.html { redirect_to root_path, notice: 'Message sent.' }
        format.json { render :show, status: :created, location: @greeting }
      else
        format.html { render :new }
        format.json { render json: @greeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /greetings/1
  # PATCH/PUT /greetings/1.json
  def update
    respond_to do |format|
      if @greeting.update(greeting_params)
        format.html { redirect_to @greeting, notice: 'Greeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @greeting }
      else
        format.html { render :edit }
        format.json { render json: @greeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /greetings/1
  # DELETE /greetings/1.json
  def destroy
    @greeting.destroy
    respond_to do |format|
      format.html { redirect_to greetings_url, notice: 'Greeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_greeting
      @greeting = Greeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def greeting_params
      params.require(:greeting).permit(:name, :message)
    end
end
