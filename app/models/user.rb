class User < ApplicationRecord
	# include PublicActivity::Common
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :tasks
end
