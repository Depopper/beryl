class UsersController < ApplicationController


  skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:auth] = @user.to_session
      redirect_to profil_path, success: 'Votre compte a bien ete cree !'
    else
      render 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:username, :email, :firstname, :lastename, :avatar_file)
    if @user.update(user_params)
      redirect_to profil_path, success: 'Votre compte a ete mis a jour !'
    else
      render :edit
    end
  end

end
