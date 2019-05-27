require 'rails_helper'

RSpec.describe Post, type: :model do
	
	context 'validation tests' do
		
		before(:all) do
			@post = create(:post)
		end

		it 'is valid with valid attributes' do
			expect(@post).to be_valid
		end

		it 'ensure title present' do
			@post = build(:post, title: nil, user_id: 1, description: 'helo')
			expect(@post).to_not be_valid
		end

		it 'ensure description present' do
			@post = build(:post, description: nil, user_id: 1, title: 'test')
			expect(@post).to_not be_valid
		end

		it 'can not be saved without an user' do
			@post = build(:post, user_id: nil, title: 'test', description: 'test')
			expect(@post).to_not be_valid
		end
	end

	context 'after create' do
		before(:all) do
			@post = create(:post)
		end

		it 'send email' do
			expect(MailerWorker.perform_async('PostMailer', 'send_notification', @post.id)).to have_enqueued_job.on_queue('mailers')
		end
	end

	context 'scope tests' do
	end
end