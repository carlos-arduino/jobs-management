# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  protected
  
  def after_sign_in_path_for(resource)
    companies_path
  end
  
end
