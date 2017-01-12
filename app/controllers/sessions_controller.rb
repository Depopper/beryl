class SessionsController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]

  def new
    @user = User.new

  end

  def create
    user_params = params.require(:user)
    @user = User.where(username: user_params[:username]).or(User.where(email: user_params[:username])).first
    if @user and @user.authenticate(user_params[:password])
      session[:auth] = @user.to_session
      redirect_to profil_path, success: 'Connection reussi !'
    else
      redirect_to new_session_path, danger: 'Identifiants incorrects'
    end
  end

  def destroy
    if session[:auth] and session[:auth]['id']
      session.destroy
    end
    redirect_to new_session_path
  end
end
