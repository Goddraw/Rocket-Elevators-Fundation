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
  end

  # GET /interventions/1/edit
  def edit
  end

  # POST /interventions or /interventions.json
  def create
    @intervention = Intervention.new(intervention_params)

    respond_to do |format|
      if @intervention.save

        format.html { redirect_to intervention_url(@intervention), notice: "Intervention was successfully created." }
        format.json { render :show, status: :created, location: @intervention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @intervention.errors, status: :unprocessable_entity }
      end
    end
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





  # def get_buildings_by_customer
  #   @Buildings = Building.where("customer_id = ?", params[:customerID])
  #   respond_to do |format|
  #     format.json { render :json => @Buildings }
  #   end
  # end 
  # def building_search
  #   if params[:customer].present? && params[:customer].strip != ""
  #     @Buildings = Customer.where("customer_id = ?", params[:customer])
  #   else
  #     @Buildings = Building.all
  #   end
  # end

  # DELETE /interventions/1 or /interventions/1.json
  def destroy
    @intervention.destroy

    respond_to do |format|
      format.html { redirect_to interventions_url, notice: "Intervention was successfully destroyed." }
      format.json { head :no_content }
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


