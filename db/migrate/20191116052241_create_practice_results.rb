class CreatePracticeResults < ActiveRecord::Migration[5.2]
  def change
    create_table :practice_results do |t|
      t.string :chart_of_practice
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
