require "application_system_test_case"

class GreetingsTest < ApplicationSystemTestCase
  setup do
    @greeting = greetings(:one)
  end

  test "visiting the index" do
    visit greetings_url
    assert_selector "h1", text: "Greetings"
  end

  test "creating a Greeting" do
    visit greetings_url
    click_on "New Greeting"

    fill_in "Message", with: @greeting.message
    fill_in "Name", with: @greeting.name
    click_on "Create Greeting"

    assert_text "Greeting was successfully created"
    click_on "Back"
  end

  test "updating a Greeting" do
    visit greetings_url
    click_on "Edit", match: :first

    fill_in "Message", with: @greeting.message
    fill_in "Name", with: @greeting.name
    click_on "Update Greeting"

    assert_text "Greeting was successfully updated"
    click_on "Back"
  end

  test "destroying a Greeting" do
    visit greetings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Greeting was successfully destroyed"
  end
end
