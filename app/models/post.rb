class Post < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :description, presence: true

	after_create :send_email

	def send_email
		MailerWorker.perform_async('PostMailer', 'send_notification', self.id)
	end
end
