require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
    test "get signup form and create user" do

        get signup_path
        assert_template 'users/new'
        # test create
        assert_difference 'User.count', 1 do
            post users_path, params: { user: {username: "johnsmith", email: "johns@example.com", password: "password", admin: false}}
            follow_redirect!
        end
        # redirect to index
        assert_template 'users/show'
        # sports should be matched in the new page
        assert_match "johnsmith", response.body
    end
end