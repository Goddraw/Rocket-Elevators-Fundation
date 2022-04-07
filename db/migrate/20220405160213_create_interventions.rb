class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.string :author
      t.string :customerID
      t.string :buildingID
      t.string :batteryID
      t.string :columnID
      t.string :elevatorID
      t.string :employeeID
      t.datetime :startDateAndTimeOfIntervention, null: true
      t.datetime :endDateAndTimeOfIntervention, null: true
      t.string :result, default: "Incomplete"
      t.text :report
      t.string :status, default: "Pending"

      t.timestamps
    end
  end
end
