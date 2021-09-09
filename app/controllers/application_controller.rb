class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # confirms a logged in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:error] = 'Please log in.'
      redirect_to login_path
    end
  end
end
