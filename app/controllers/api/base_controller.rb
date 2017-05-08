class Api::BaseController < ApplicationController
  #To identify HTML forms that are create by your rails app,
 #rails adds an hidden field that contains a CSRF token
 #For a JSON API, we want to skip this security check and use our own, This is necessary otherwise Rails will disallow
 # all Post requests made without a CSRF token signed with Rails Secret from 'config/secret.yml'
 skip_before_filter :verify_authenticity_token
 before_action :authenticate_user

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.nil?
  end


end
