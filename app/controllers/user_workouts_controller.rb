class UserWorkoutsController < ApplicationController
  # Ensures the user is authenticated before accessing any action in this controller.
  before_action :authenticate_user!
  # Sets the specific workout for actions like show edit update  destroy.
  before_action :set_user_workout, only: %i[show edit update destroy]

  def index
    # Retrieves all workouts belonging to the currently logged-in user.
    @user_workouts = current_user.user_workouts
  end

  def show
    # Displays details for a single workout. 
  end

  def new
    # Initializes a new workout associated with the current user.
    @user_workout = current_user.user_workouts.build
  end

  def create
    # Builds a new workout with the submitted parameters and associates it with the current user.
    @user_workout = current_user.user_workouts.build(user_workout_params)
    if @user_workout.save
      # Redirects to the workouts index page if the workout is successfully saved.
      redirect_to user_workouts_path, notice: "Workout successfully created."
    else
      # Re-renders the new form with validation errors if saving fails.
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Loads the workout to be edited. The workout is already set by set_user_workout.
  end

  def update
    # Updates the selected workout with the submitted parameters.
    if @user_workout.update(user_workout_params)
      # Redirects to the workouts index page if the update is successful.
      redirect_to user_workouts_path, notice: "Workout successfully updated."
    else
      # Re-renders the edit form with validation errors if the update fails.
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Deletes the selected workout and redirects to the workouts index page with a success message.
    @user_workout.destroy
    redirect_to user_workouts_path, notice: "Workout successfully deleted."
  end

  private

  def set_user_workout
    # Finds the workout belonging to the current user based on the provided id.
    @user_workout = current_user.user_workouts.find(params[:id])
  end

  def user_workout_params
    # Whitelists the parameters allowed for creating or updating a workout.
    params.require(:user_workout).permit(:name, :description, :sets, :reps, :date)
  end
end
