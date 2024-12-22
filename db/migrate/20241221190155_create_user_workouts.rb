class CreateUserWorkouts < ActiveRecord::Migration[8.0]
  def change
    create_table :user_workouts do |t|
      t.string :name
      t.text :description
      t.decimal :sets
      t.decimal :reps
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
