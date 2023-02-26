class UsersController < ApplicationController
  before_action :load_and_authorize_user, except: %i[index]

  def index
    authorize User
    @users = User.page(params[:page]).per(10)
  end

  def update
    if @user.update(permitted_attributes)
      redirect_back(fallback_location: users_path, notice: t('.notice'))
    else
      render :edit, status: :unprocessable_entity, alert: t('.alert')
    end
  end

  def destroy
    options =
      if @user.destroy
        { notice: t('.notice') }
      else
        { alert: t('.alert') }
      end
    redirect_to users_path, **options
  end

  private

  def load_and_authorize_user
    @user = User.find(params[:id])
    authorize @user
  end

  def permitted_attributes
    params.require(:user).permit(:name, role_ids: [])
  end
end
