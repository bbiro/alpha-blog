require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

    def setup
        @user = User.create(username: "johny", email: "john@example.com", password: "password", admin: true)
    end

    test "get article form and create article" do
        
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        # test create
        assert_difference 'Article.count', 1 do
            post articles_path, params: { article: {title: "Test title", description: "test description"}}
            follow_redirect!
        end
        # redirect to index
        assert_template 'articles/show'
        # sports should be matched in the new page
        assert_match "Test title", response.body
    end
end