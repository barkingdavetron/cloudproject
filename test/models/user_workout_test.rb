require "test_helper"

class UserWorkoutTest < ActiveSupport::TestCase
  # This setup block runs before each test
  setup do
    # Create a user to associate with workout as workouts require a user
    @user = User.create(email: "test@example.com", password: "password123")

    # Create a sample workout to use in the tests
    @workout = UserWorkout.create(
      name: "Morning Workout",        
      description: "Chest press",    
      sets: 3,                        
      reps: 12,
      date: Date.today,              
      user: @user                    
    )
  end

  # Test for creating a new workout
  test "create a valid workout" do
    # Define a new workout with valid attributes
    workout = UserWorkout.new(
      name: "Evening Workout",       
      description: "Leg press",      
      sets: 4,                      
      reps: 10,                      
      date: Date.today,             
      user: @user                    
    )

    # Check if the workout saves successfully
    assert workout.save, "Workout did not save successfully"
  end

  # Test for reading an existing workout
  test "should read an existing workout" do
    # Find the workout by its name
    workout = UserWorkout.find_by(name: "Morning Workout")
    
    # Check if the workout is found
    assert_not_nil workout, "Failed to find the workout"

    # Ensure the workout name matches what was created
    assert_equal @workout.name, workout.name, "Workout name does not match"
  end

  # Test for updating a workout
  test "should update a workout" do
    # Attempt to update the workouts name and sets
    assert @workout.update(name: "Updated Workout", sets: 5), "Failed to update the workout"

    # Fetch the updated workout from the database
    updated_workout = UserWorkout.find(@workout.id)

    # Verify the workouts name was updated
    assert_equal "Updated Workout", updated_workout.name, "Workout name was not updated"

    # Verify the workouts sets were updated
    assert_equal 5, updated_workout.sets, "Workout sets were not updated"
  end

  # Test for saving a workout without a name
  test "should not save workout without a name" do
  # Create a new workout with no name
  workout = UserWorkout.new(
    name: nil,                        # No name provided
    description: "Push-ups",         
    sets: 3,                     
    reps: 15,                         
    date: Date.today,               
    user: @user                       
  )

  # Assert that the workout does not save
  assert_not workout.save, "Saved the workout without a name"
end

  # Test for deleting a workout
  test "should delete a workout" do
    # Check that the workout count decreases by 1 after deletion
    assert_difference('UserWorkout.count', -1, "Workout was not deleted") do
      @workout.destroy # Delete the workout
    end
  end
end
