FactoryBot.define do
	
	factory :user do
		sequence(:email) { |n| "test-#{n}@test.com" }
		password { '123456' }
	end

	factory :post do
		association :user
		title { 'testing' }
		description { 'post model testing' }
	end
end