require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Toppage | Insta Clone"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Insta Clone"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "What's 'InstaClone?' | Insta Clone"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "利用規約 | Insta Clone"
  end
end
