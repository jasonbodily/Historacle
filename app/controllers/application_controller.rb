class ApplicationController < ActionController::Base

  def here
    render 'homebase/testground'
  end

  protect_from_forgery

  def after_sign_in_path_for(user)
    "/library"
  end

end