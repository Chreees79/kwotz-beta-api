class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  # GET /user_profiles
  def index
    @user_profiles = UserProfile.all

    render json: @user_profiles
  end

  # GET /user_profiles/1
  def show
    return unless @user_profile.user == current_user
    render json: @user_profile
  end

  # POST /user_profiles
  def create
    @user_profile = UserProfile.new(user_profile_params)
    @user_profile.user = current_user

    if @user_profile.save
      render json: @user_profile, status: :created, location: @user_profile
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_profiles/1
  def update
    if @user_profile.update(user_profile_params) && @user_profile.user == current_user
      render json: @user_profile
    else
      render json: @user_profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_profiles/1
  def destroy
    return unless @user_profile.user == current_user

    @user_profile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_profile
      @user_profile = UserProfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_profile_params
      params.require(:user_profile).permit(:user_id, :company, :address, :zipcode, :city, :role, :first_name, :last_name, :shipping_alias, :shipping_address, :shipping_zipcode, :shipping_city, :phone_number)
    end
end
