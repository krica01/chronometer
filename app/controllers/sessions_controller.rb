class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      session[:email] = params[:session][:email]
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def create_new_user
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      session[:email] = params[:email]
      redirect_to homepage_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to homepage_path
    end
  end

  def destroy
    log_out
    session.clear

    redirect_to root_url
  end
end