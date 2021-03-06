class RacesController < ApplicationController
  before_action :logged_in_user
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  layout "chron_layout"

  # GET /races
  # GET /races.json
  def index
    @races = Race.all.where(:user_id => session[:user_id])
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
	@race.user_id = session[:user_id]
	
	num = params[:no_racers].to_i

	i = 0
	#$num = 5

	(1..num).each do |i|
		puts "Racer - " + i.to_s
   		@racer = Racer.new(:name => "Racer " + i.to_s )
   		@racer.race = @race
		@race.racers << @racer
   		i +=1
   		
	end
	
	
	num = params[:no_rzs].to_i
	
	i = 1
	#$num = 5
	
	(1..num).each do |i|
		puts "RZ - " + i.to_s
  		@rz = Rz.new(:name => "RZ"+i.to_s)
		@race.rzs << @rz
   		i +=1
	end
	
	@race.rzs.each do |rz|
		puts 'rzrecord RZ' + rz.id.to_s
		@race.racers.each do |racer|
				puts 'rzrecord Racer' + racer.id.to_s
			rzRecord = RzRecord.new()
			rzRecord.racer = racer
			rzRecord.race = @race
			rzRecord.rz = rz
			rz.rz_records << rzRecord
			racer.rz_records << rzRecord
		end
	end 
		

    respond_to do |format|
      if @race.save
        format.html { render :edit, :race => @race, notice: 'Race was successfully created.' }
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
  	@races = []
  	if !Race.find_by(:user_id => session[:user_id]).nil?
  		ra = Race.where(:user_id => session[:user_id])
  		ra.each do |race|
  			@races << race
  		end
  	end
  	if !Race.getContributingRaces(session[:user_id]).nil?
  		@races = @races | Race.getContributingRaces(session[:user_id])
  	end	

    render action: "startraces.html.erb"
  end
  
  
  
  # SHOW race RZ /race/1/show-rzs
  def show_rzs_finish
  	@race = Race.find_by(:id => params[:id])
  	
    render action: "showrzs_finish.html.erb"
  
  end
  
  
  # SHOW race RZ /race/1/start-rz/1
  def finish_rz
  	@race = Race.find_by(:id => params[:id])
  	@rz = Rz.find_by(:id => params[:rzid], :race_id => params[:id])

    render action: "finishrz.html.erb"
  end
  
    # SHOW start races list
    #races/start-races
  def finish_races
  	@races = []
  	if Race.find_by(:user_id => session[:user_id]) != nil
  		ra = Race.where(:user_id => session[:user_id])
  		ra.each do |race|
  			@races << race
  		end
  	end
  	if !Race.getContributingRaces(session[:user_id]).nil?
  		@races = @races | Race.getContributingRaces(session[:user_id])
  	end
  	
    render action: "finishraces.html.erb"
  end
  
  # SHOW assign_names
  def assign_names
  	@race = Race.find_by(:id => params[:id])
  	
  	render action: "assign_names.html.erb"
  end
  
  # PUT assign_name
  def assign_name
  	@racer = Racer.find_by(:id => params[:id])
  	
  	@racer.nickname = params[:nickname]
  	
  	@racer.save
  	 respond_to do |format|
        format.js {render action: "edit_name.html.erb"}
    end
  	

  end
  
  # PUT assign_name
  def assign_race_permission
  	@race = Race.find_by(:id => params[:id])
  	
  	user = User.find_by(:email => params[:user_email])
  	
  	@race_permission = RacePermission.new()
  	@race_permission.race = @race
  	@race_permission.user = user
	puts 'AAAA'
	puts @race_permission.user_id 
	puts @race_permission.race_id 
  	
  	@race_permission.save
  	
  	puts @race_permission 

	redirect_to :action => :edit

  end
  
  # Delete RZ /races/delete_rz/:id/:rz_id
  def delete_rz
  	@race = Race.find(params[:id])
  	
  	rz = @race.rzs.find(params[:rz_id])
	if !rz.nil?
		rz_records = RzRecord.where(:rz_id => rz.id)
		rz_records.each do |rz_record|
			rz_record.destroy
		end

		rz.destroy
	end
	

	
	redirect_to :controller => 'results', :action => 'show_results', :id => @race.id
  end
  
  
  def delete_race_permission
  	@race_permission = RacePermission.find(params[:race_permission_id])
  	@race = Race.find(params[:id])
  	
  	@race_permission.destroy
  	
  	redirect_to :action => :edit
  	
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
