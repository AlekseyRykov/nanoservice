require "application_system_test_case"

class MessengersTest < ApplicationSystemTestCase
  setup do
    @messenger = messengers(:one)
  end

  test "visiting the index" do
    visit messengers_url
    assert_selector "h1", text: "Messengers"
  end

  test "creating a Messenger" do
    visit messengers_url
    click_on "New Messenger"

    click_on "Create Messenger"

    assert_text "Messenger was successfully created"
    click_on "Back"
  end

  test "updating a Messenger" do
    visit messengers_url
    click_on "Edit", match: :first

    click_on "Update Messenger"

    assert_text "Messenger was successfully updated"
    click_on "Back"
  end

  test "destroying a Messenger" do
    visit messengers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Messenger was successfully destroyed"
  end
end
