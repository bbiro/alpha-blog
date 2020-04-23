require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
    
    test "get new category form and create category" do
        get new_category_path
        assert_template 'categories/new'
        # test create
        assert_difference 'Category.count', 1 do
            post categories_path, params: { category: {name: "sports"}}
            follow_redirect!
        end
        # redirect to index
        assert_template 'categories/index'
        # sports should be matched in the new page
        assert_match "sports", response.body
    end

    test "invalid category submission results in failure" do
        get new_category_path
        assert_template 'categories/new'
        # test create, but should not be difference - error is happening
        assert_no_difference 'Category.count', 1 do
            post categories_path, params: { category: {name: " "}}
        end
        # redirect to the same new page
        assert_template 'categories/new'
        assert_select 'h4.alert-heading'
    end

end