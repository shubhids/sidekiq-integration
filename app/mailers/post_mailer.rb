class PostMailer < ApplicationMailer

	def send_notification(post_id)
		@post = Post.find(post_id)
		mail subject: "New Post Created", to: @post.user.email
	end
end