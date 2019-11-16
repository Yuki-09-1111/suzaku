class CreateCurrentRecrutingEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :current_recruting_events do |t|
      t.string :end_of_application
      t.string :date_of_event
      t.string :event_name
      t.string :application_form
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
