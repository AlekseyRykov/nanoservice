require 'test_helper'

class MessengersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @messenger = messengers(:one)
  end

  test "should get index" do
    get messengers_url
    assert_response :success
  end

  test "should get new" do
    get new_messenger_url
    assert_response :success
  end

  test "should create messenger" do
    assert_difference('Messenger.count') do
      post messengers_url, params: { messenger: {  } }
    end

    assert_redirected_to messenger_url(Messenger.last)
  end

  test "should show messenger" do
    get messenger_url(@messenger)
    assert_response :success
  end

  test "should get edit" do
    get edit_messenger_url(@messenger)
    assert_response :success
  end

  test "should update messenger" do
    patch messenger_url(@messenger), params: { messenger: {  } }
    assert_redirected_to messenger_url(@messenger)
  end

  test "should destroy messenger" do
    assert_difference('Messenger.count', -1) do
      delete messenger_url(@messenger)
    end

    assert_redirected_to messengers_url
  end
end
