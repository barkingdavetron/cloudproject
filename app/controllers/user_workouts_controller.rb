class UserWorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_workout, only: %i[show edit update destroy]

  def index
    @user_workouts = current_user.user_workouts
  end

  def show
  end

  def new
    @user_workout = current_user.user_workouts.build
  end

  def create
    @user_workout = current_user.user_workouts.build(user_workout_params)
    if @user_workout.save
      redirect_to user_workouts_path, notice: "Workout successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user_workout.update(user_workout_params)
      redirect_to user_workouts_path, notice: "Workout successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_workout.destroy
    redirect_to user_workouts_path, notice: "Workout successfully deleted."
  end

  private

  def set_user_workout
    @user_workout = current_user.user_workouts.find(params[:id])
  end

  def user_workout_params
    params.require(:user_workout).permit(:name, :description, :sets, :reps, :date)
  end
end
