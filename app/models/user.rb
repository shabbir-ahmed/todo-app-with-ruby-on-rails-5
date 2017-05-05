class User < ApplicationRecord
	# include PublicActivity::Common
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :tasks, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :conversations, foreign_key: :sender_id, dependent: :destroy
end
