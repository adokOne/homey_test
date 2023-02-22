class UsersController < ApplicationController
  before_action :load_user, except: %i[index]

  def index
    authorize User
    @users = User.page(params[:page]).per(10)
  end

  def update
    if @user.update(permitted_attributes)
      redirect_back(fallback_location: users_path, notice: 'User was successfully created.')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    options =
      if @user.destroy
        { notice: "User was successfully destroyed." }
      else
        { alert: "User can not be destroyed." }
      end
    redirect_to users_path, **options
  end

  private

  def load_user
    @user = User.find(params[:id])
    authorize @user
  end

  private

  def permitted_attributes
    params.require(:user).permit(:name, role_ids: [])
  end
end
