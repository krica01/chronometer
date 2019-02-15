class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  layout "chron_layout"

  # GET /races
  # GET /races.json
  def index
    @races = Race.all
  end

  # GET /races/1
  # GET /races/1.json
  def show
  end

  # GET /races/new
  def new
    @race = Race.new
  end

  # GET /races/1/edit
  def edit
  end

  # POST /races
  # POST /races.json
  def create
    @race = Race.new(race_params)

	
	num = params[:no_racers].to_i

	i = 0
	#$num = 5

	(1..num).each do |i|
		puts "Racer - " + i.to_s
   		@racer = Racer.new(:id => i, :name => "s")
		@race.racers << @racer
   		i +=1
	end
	
	
	num = params[:no_rzs].to_i
	
	i = 1
	#$num = 5
	
	(1..num).each do |i|
		puts "RZ - " + i.to_s
   		@rz = Rz.new(:id => i, :name => "s")
		@race.rzs << @rz
   		i +=1
	end
		

    respond_to do |format|
      if @race.save
        format.html { redirect_to @race, notice: 'Race was successfully created.' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update
    respond_to do |format|
      if @race.update(race_params)
        format.html { redirect_to @race, notice: 'Race was successfully updated.' }
        format.json { render :show, status: :ok, location: @race }
      else
        format.html { render :edit }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to races_url, notice: 'Race was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  # SHOW race RZ /race/1/show-rzs
  def show_rzs
  	@race = Race.find_by(:id => params[:id])
  	
    render action: "showrzs.html.erb"
  
  end
  
  # SHOW race RZ /race/1/start-rz/1
  def start_rz
  	@race = Race.find_by(:id => params[:id])
  	@rz = Rz.find_by(:id => params[:rzid], :race_id => params[:id])
  	
    render action: "startrz.html.erb"
  end
  
    # SHOW start races list
    #races/start-races
  def start_races
  	@races = Race.all
  	
    render action: "startraces.html.erb"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:name, :place, :date)
    end
end