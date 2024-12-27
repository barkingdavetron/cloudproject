require "test_helper"

class UserWorkoutTest < ActiveSupport::TestCase
  # this setup block runs before each test
  setup do
    # create a user to associate with workouts as workouts require a user
    @user = User.create(email: "test@example.com", password: "password123")

    # create a sample workout to use in the tests
    @workout = UserWorkout.create(
      name: "Morning Workout",
      description: "Chest press",
      sets: 3,
      reps: 12,
      date: Date.today,
      user: @user
    )
  end

  ### Validation Tests ###

  # test for saving a workout without a name
  test "should not save workout without a name" do
    # create a new workout with no name
    workout = UserWorkout.new(
      name: nil,                        # No name provided
      description: "Push-ups",
      sets: 3,
      reps: 15,
      date: Date.today,
      user: @user
    )

    # assert that the workout does not save
    assert_not workout.save, "Saved the workout without a name"
  end

  # test for saving a workout without a user
  test "should not save workout without a user" do
    # create a new workout with no associated user
    workout = UserWorkout.new(
      name: "Solo Workout",
      description: "Squats",
      sets: 4,
      reps: 12,
      date: Date.today,
      user: nil
    )

    # assert that the workout does not save
    assert_not workout.save, "Saved the workout without a user"
  end

  ### CRUD Operation Tests ###

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

    # check if the workout saves successfully
    assert workout.save, "Workout did not save successfully"
  end

  # test for reading an existing workout
  test "should read an existing workout" do
    # find the workout by its name
    workout = UserWorkout.find_by(name: "Morning Workout")

    # check if the workout is found
    assert_not_nil workout, "Failed to find the workout"

    # ensure the workout name matches what was created
    assert_equal @workout.name, workout.name, "Workout name does not match"
  end

  # test for updating a workout
  test "should update a workout" do
    # attempt to update the workout's name and sets
    assert @workout.update(name: "Updated Workout", sets: 5), "Failed to update the workout"

    # fetch the updated workout from the database
    updated_workout = UserWorkout.find(@workout.id)

    # verify the workout's name was updated
    assert_equal "Updated Workout", updated_workout.name, "Workout name was not updated"

    # verify the workout's sets were updated
    assert_equal 5, updated_workout.sets, "Workout sets were not updated"
  end

  # test for deleting a workout
  test "should delete a workout" do
    # check that the workout count decreases by 1 after deletion
    assert_difference('UserWorkout.count', -1, "Workout was not deleted") do
      @workout.destroy # delete the workout
    end
  end

  ### Association Tests ###

  # test for a workout belonging to a user
  test "workout should belong to a user" do
    # assert that the workout's user matches the created user
    assert_equal @user.id, @workout.user_id, "Workout does not belong to the correct user"
  end

  # test for a user having many workouts
  test "user should have many workouts" do
    # create a second workout for the user
    second_workout = UserWorkout.create(
      name: "Evening Workout",
      description: "Leg press",
      sets: 4,
      reps: 10,
      date: Date.today,
      user: @user
    )

    # assert that the user has exactly two workouts
    assert_equal 2, @user.user_workouts.count, "User does not have the correct number of workouts"
  end
end
