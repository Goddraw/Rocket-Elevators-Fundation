json.extract! intervention, :id, :author, :customerID, :buildingID, :batteryID, :columnID, :elevatorID, :employeeID, :startDateAndTimeOfIntervention, :endDateAndTimeOfIntervention, :result, :report, :status, :created_at, :updated_at
json.url intervention_url(intervention, format: :json)
