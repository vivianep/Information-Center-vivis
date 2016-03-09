require 'test_helper'

class UserTest < ActiveSupport::TestCase
	
	test "user without email" do
		user = User.new(:name => 'Viviane' )
		assert_not user.save, "Did not save user without name " 
	end

	test "user without name" do
		user = User.new(:email=> 'vivianec@gmail.com' )
		assert_not user.save, "Did not save user without name " 
	end

	test "user with name and email" do
		user = User.new(:name=> 'Vivi',:email=> 'vivianec@gmail.com' )
		assert user.save, "Did not save user with name and email " 
	end

	test "user with same email as other" do
		user = User.new(:name=> 'Beatriz Vasconcelos',:email=> 'beatrizv@gmail.com' )
		assert_not user.save, "Did not save user with name and email " 
	end

	test "user with same name" do
		user = User.new(:name=> 'Beatriz Vasconcelos',:email=> 'beatriz@gmail.com' )
		assert user.save, "Did not save user with name and email " 
	end
	


end
