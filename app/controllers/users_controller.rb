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

  def update
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
end
