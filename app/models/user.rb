class User < ApplicationRecord
	# include PublicActivity::Common
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :visits, dependent: :destroy
    has_many :ahoy_events, dependent: :destroy
    has_many :tasks, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :conversations, foreign_key: :sender_id, dependent: :destroy

    scope :active, -> {where('status': "Active")}
    scope :deactivate, -> {where('status': "Deactivate")}
end
