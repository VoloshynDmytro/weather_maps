class Api::UsersController < Api::ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def show
    render :json => {:info => "Current User", :user => current_user}, :status => 200
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      sign_in(@user)
      render json: @user, status: :created, location: api_users_path(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end

end

