require 'test_helper'

class HipchatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hipchat = hipchats(:one)
  end

  test "should get index" do
    get hipchats_url
    assert_response :success
  end

  test "should get new" do
    get new_hipchat_url
    assert_response :success
  end

  test "should create hipchat" do
    assert_difference('Hipchat.count') do
      post hipchats_url, params: { hipchat: { article_id: @hipchat.article_id, author: @hipchat.author, description: @hipchat.description, title: @hipchat.title } }
    end

    assert_redirected_to hipchat_url(Hipchat.last)
  end

  test "should show hipchat" do
    get hipchat_url(@hipchat)
    assert_response :success
  end

  test "should get edit" do
    get edit_hipchat_url(@hipchat)
    assert_response :success
  end

  test "should update hipchat" do
    patch hipchat_url(@hipchat), params: { hipchat: { article_id: @hipchat.article_id, author: @hipchat.author, description: @hipchat.description, title: @hipchat.title } }
    assert_redirected_to hipchat_url(@hipchat)
  end

  test "should destroy hipchat" do
    assert_difference('Hipchat.count', -1) do
      delete hipchat_url(@hipchat)
    end

    assert_redirected_to hipchats_url
  end
end
