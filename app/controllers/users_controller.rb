class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :create, :update, :destroy]

  def new

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Profil mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def correct_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_back fallback_location: root_path, alert: "Accès non autorisé"
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :avatar)
  end

end
