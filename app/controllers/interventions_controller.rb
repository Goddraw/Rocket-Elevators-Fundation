class InterventionsController < ApplicationController
  before_action :set_intervention, only: %i[ show edit update destroy ]

  require 'uri'
  require 'open-uri'
  require 'fileutils'
  require 'json'
  require 'rest_client'

  # GET /interventions or /interventions.json
  def index
    @interventions = Intervention.all
  end

  # GET /interventions/1 or /interventions/1.json
  def show
  end

  # GET /interventions/new
  def new
    @intervention = Intervention.new
    @customer = Customer.all
    @building = Building.all
    @battery = Battery.all
    @column = Column.all
    @elevator = Elevator.all
    @employee = Employee.all
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions or /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)
    #respond_to do |format|
      if @intervention.save

        author = Employee.find(@intervention.author)
        authorName = author.first_name + " " + author.last_name
        if @intervention.customerID != nil 
          companyName = Customer.find(@intervention.customerID).Company_Name
        else
          companyName = "n/a"
        end
        if @intervention.buildingID == nil
          @intervention.buildingID = "n/a"
        end
        if @intervention.batteryID == nil
          @intervention.batteryID = "n/a"
        end
        if @intervention.columnID == nil
          @intervention.columnID = "n/a"
        end
        if @intervention.elevatorID == nil
          @intervention.elevatorID = "n/a"
        end
        
        if @intervention.employeeID == nil
          @intervention.employeeID = "n/a"
          employeeName = "n/a"
        else
          employee = Employee.find(@intervention.employeeID)
          employeeName = employee.first_name + " " + employee.last_name
        end

        if @intervention.report == nil
          @intervention.report = "n/a"
        end

      #     data = {
      #       "status": 2, 
      #       "priority": 1,
      #       "email": "admin@rocketelevators.com",
      #       "description": 
      #         "A new intervention has been submitted by employee " + authorName + " for the company, " + companyName + ". The building ID is " + @intervention.buildingID.to_s + "; battery ID is " + @intervention.batteryID.to_s + ". The column ID is " + @intervention.columnID.to_s + ". The elevator ID is " + @intervention.elevatorID.to_s + ". The employee to be assigned to the task is " + employeeName + ". Description of the request for the intervention is: " + @intervention.report, 
      #       "type": "Incident",
      #       "subject": "New intervention submitted for building No." + @intervention.buildingID.to_s
      #     }

      #     puts data
      #     data_json = JSON.generate(data)
      #       request = RestClient::Request.execute(
      #         method: :post,
      #         url: ENV["FRESHDESK_API_KEY"],
      #         user: ENV["FRESHDESK_URL"],
      #         password: 'X',
      #         payload: data_json,
      #         headers: {"Content-Type" => 'application/json'}
      #       )
  
      #       logger.debug "----------- #{request.code} --------------"

      #   format.html { redirect_to root_path, notice: "Intervention was successfully created." }
      #   format.json { render :show, status: :created, location: @intervention }
      # else
      #   format.html { render :new, status: :unprocessable_entity }
      #   format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /interventions/1 or /interventions/1.json
  def update
    respond_to do |format|
      if @intervention.update(intervention_params)
        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully updated." }
        format.json { render :show, status: :ok, location: @intervention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
  end




#Get buildings for dropdown menu
  def get_buildings
    @buildings = Building.where("customer_id = ?", params[:customer_id])
    respond_to do |format|
      format.json { render :json => @buildings }
    end
  end 

#Get batteries for dropdown menu
def get_batteries
  @batteries = Battery.where("building_id = ?", params[:building_id])
  respond_to do |format|
    format.json { render :json => @batteries }
  end
end 

#Get columns for dropdownmenu
def get_columns
  @columns = Column.where("battery_id = ?", params[:battery_id])
  respond_to do |format|
    format.json { render :json => @columns }
  end
end 

#Get elevators for dropdownmenu

def get_elevators
  @elevators = Elevator.where("column_id = ?", params[:column_id])
  respond_to do |format|
    format.json { render :json => @elevators }
  end
end 

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #The gets for my ajax calls
  def get_building_by_customer
    @building = Building.where("customer_id = ?", params[:customer_id])
    respond_to do |format|
        format.json { render :json => @building }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intervention
      @intervention = Intervention.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def intervention_params
      params.require(:intervention).permit(:author, :customerID, :buildingID, :batteryID, :columnID, :elevatorID, :employeeID, :startDateAndTimeOfIntervention, :endDateAndTimeOfIntervention, :result, :report, :status)
    end



end