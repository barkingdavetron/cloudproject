class AddFavoriteToUserWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :user_workouts, :favorite, :boolean
  end
end
