class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = "You're now logged in"
      redirect_to user
    else
      flash.now[:error] = 'Invalid email/password combination.'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = "You're now logged out"
    redirect_to root_url
  end
end
