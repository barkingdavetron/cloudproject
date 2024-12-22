require "test_helper"

class UserWorkoutTest < ActiveSupport::TestCase
  test "should save workout with a name" do
    # Create a user or else test will fail
    user = User.create(email: "test@example.com", password: "password123")

    # Create a valid UserWorkout which will be tested
    workout = UserWorkout.new(
      name: "Morning Workout",
      description: "A great way to start the day",
      sets: 3,
      reps: 12,
      date: Date.today,
      user: user # Set user association
    )

    # Assert that the workout saves successfully
    assert workout.save, "Workout did not save even though it has a valid name"
  end
end
