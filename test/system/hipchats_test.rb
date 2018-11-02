require "application_system_test_case"

class HipchatsTest < ApplicationSystemTestCase
  setup do
    @hipchat = hipchats(:one)
  end

  test "visiting the index" do
    visit hipchats_url
    assert_selector "h1", text: "Hipchats"
  end

  test "creating a Hipchat" do
    visit hipchats_url
    click_on "New Hipchat"

    fill_in "Article", with: @hipchat.article_id
    fill_in "Author", with: @hipchat.author
    fill_in "Description", with: @hipchat.description
    fill_in "Title", with: @hipchat.title
    click_on "Create Hipchat"

    assert_text "Hipchat was successfully created"
    click_on "Back"
  end

  test "updating a Hipchat" do
    visit hipchats_url
    click_on "Edit", match: :first

    fill_in "Article", with: @hipchat.article_id
    fill_in "Author", with: @hipchat.author
    fill_in "Description", with: @hipchat.description
    fill_in "Title", with: @hipchat.title
    click_on "Update Hipchat"

    assert_text "Hipchat was successfully updated"
    click_on "Back"
  end

  test "destroying a Hipchat" do
    visit hipchats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Hipchat was successfully destroyed"
  end
end
