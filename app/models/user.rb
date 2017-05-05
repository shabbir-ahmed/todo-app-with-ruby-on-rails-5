class User < ApplicationRecord
    after_create :send_welcome_email
	# include PublicActivity::Common
	include PublicActivity::Model
	tracked owner: ->(controller, model) { controller && controller.current_user }
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :tasks
    has_many :messages
    has_many :conversations, foreign_key: :sender_id

    private

    def send_welcome_email
        UserMailer.deliver_welcome_email(self)
    end
end
