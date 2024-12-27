class User < ApplicationRecord
  # Represents the User model storing user data and logic.

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Devise modules for user authentication and account management.

  has_many :user_workouts, dependent: :destroy
  # A user can have many workouts deleting a user removes their workouts.
end