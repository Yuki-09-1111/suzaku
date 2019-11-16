class CreateTournamentResults < ActiveRecord::Migration[5.2]
  def change
    create_table :tournament_results do |t|
      t.string :date_of_tournament
      t.string :name
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
