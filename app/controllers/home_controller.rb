class HomeController < ApplicationController
  	def index
  		@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user)
  	end
end
