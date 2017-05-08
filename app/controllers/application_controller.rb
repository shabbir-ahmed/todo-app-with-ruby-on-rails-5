class ApplicationController < ActionController::Base
	# before_filter :authenticate_user!
	after_action :track_action
	include PublicActivity::StoreController
  	protect_from_forgery with: :exception
  	before_action :configure_permitted_parameters, if: :devise_controller?
  
  	include ApplicationHelper
  
  	protected
  	def configure_permitted_parameters
      	devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :location])
  	end

  	def track_action
    	ahoy.track "Viewed #{controller_name}##{action_name}"
  	end
end
