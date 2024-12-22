require 'test_helper'

class UserWorkoutTest < ActiveSupport::TestCase
  test "should not save workout without a name" do
    user_workout = UserWorkout.new
    assert_not user_workout.save, "Saved the workout without a name"
  end
end
