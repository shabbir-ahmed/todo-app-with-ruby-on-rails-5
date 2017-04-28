class Task < ApplicationRecord
	include PublicActivity::Common
	# include PublicActivity::Model
  	# tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }

  	belongs_to :user

  	scope :finish, -> {where('finished': true)}
  	scope :notfinish, -> {where('finished': false)}
  	scope :published, -> {where('published': true)}
  	scope :unpublished, -> {where('published': false)}
end
