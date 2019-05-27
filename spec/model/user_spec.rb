require 'rails_helper'

RSpec.describe User, type: :model do

	

	context 'validation tests' do 
		
		before(:all) do
			@user = create(:user)
		end

		it 'is valid with valid attributes' do
			expect(@user).to be_valid
		end

		it 'has unique email' do
			@user1 = build(:user, email: @user.email)
			expect(@user1).to_not be_valid
		end

		it 'ensure password presence' do
			@user2 = build(:user, password: nil)
			expect(@user2).to_not be_valid
		end

		it 'ensure email presence' do
			@user3 = build(:user, email: nil)
			expect(@user3).to_not be_valid
		end
	end
	context 'scope tests' do
		it 'should return active users' do 
			expect(User.active_users.size).to eq(2)
		end
		it 'should return inactive users' do 
			expect(User.inactive_users.size).to eq(0)
		end
	end

end