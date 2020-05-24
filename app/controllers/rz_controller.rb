class RzController < ApplicationController

  before_action :logged_in_user
  protect_from_forgery with: :null_session
	
  # AJAX /race/:raceId/start-rz/:rzId/racer/:racerId
  def start_racer
	
  	@race = Race.find_by(:id => params[:raceId])
  	@rz = Rz.find_by(:id => params[:rzId], :race_id => params[:raceId])
  	@racer = Racer.find_by(:id => params[:racerId])
  	@rzRecord = RzRecord.startRzRecord(@rz, @racer,  params[:startTime])
  	

  	puts params[:startTime]
  	puts @rzRecord.startTime
  	
  	@rzRecord.race = @race
  	@rzRecord.save!
  	
  	render partial: "start_racer.html.erb"
  	
  	#respond_to do |format|
    #	format.json { head :ok }
	#end
  end

	# AJAX /race/:raceId/finish-rz/:rzId/racer/:racerId
  def finish_racer

  	@race = Race.find_by(:id => params[:raceId])
  	@rz = Rz.find_by(:id => params[:rzId], :race_id => params[:raceId])
  	@racer = Racer.find_by(:id => params[:racerId])
  	@rzRecord = RzRecord.finishRzRecord(@rz, @racer, params[:startTime])


  	puts params[:startTime]
  	puts @rzRecord.startTime
  	@rzRecord.race = @race
  	
  	puts 'XXX - rz_time' + @rzRecord.rz_time.to_s
  	
  	@rzRecord.save
  	
  	render partial: "finish_racer.html.erb"
  	
  	#respond_to do |format|
    #	format.json { head :ok }
	#end
  end

end
