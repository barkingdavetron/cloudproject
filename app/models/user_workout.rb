class UserWorkout < ApplicationRecord
  # Represents the UserWorkout model, storing workout data for a user.

  belongs_to :user
  # Each workout is associated with a single user.

  validates :name, presence: true
  # Ensures that a workout must have a name.

  validates :date, presence: true
  # Ensures that a workout must have a date.
end
