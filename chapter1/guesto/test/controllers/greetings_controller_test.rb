require 'test_helper'

class GreetingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @greeting = greetings(:one)
  end

  test "should get index" do
    get greetings_url
    assert_response :success
  end

  test "should get new" do
    get new_greeting_url
    assert_response :success
  end

  test "should create greeting" do
    assert_difference('Greeting.count') do
      post greetings_url, params: { greeting: { message: @greeting.message, name: @greeting.name } }
    end

    assert_redirected_to greeting_url(Greeting.last)
  end

  test "should show greeting" do
    get greeting_url(@greeting)
    assert_response :success
  end

  test "should get edit" do
    get edit_greeting_url(@greeting)
    assert_response :success
  end

  test "should update greeting" do
    patch greeting_url(@greeting), params: { greeting: { message: @greeting.message, name: @greeting.name } }
    assert_redirected_to greeting_url(@greeting)
  end

  test "should destroy greeting" do
    assert_difference('Greeting.count', -1) do
      delete greeting_url(@greeting)
    end

    assert_redirected_to greetings_url
  end
end
