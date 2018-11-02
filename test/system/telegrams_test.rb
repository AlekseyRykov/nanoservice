require "application_system_test_case"

class TelegramsTest < ApplicationSystemTestCase
  setup do
    @telegram = telegrams(:one)
  end

  test "visiting the index" do
    visit telegrams_url
    assert_selector "h1", text: "Telegrams"
  end

  test "creating a Telegram" do
    visit telegrams_url
    click_on "New Telegram"

    fill_in "Article", with: @telegram.article_id
    fill_in "Author", with: @telegram.author
    fill_in "Description", with: @telegram.description
    fill_in "Title", with: @telegram.title
    click_on "Create Telegram"

    assert_text "Telegram was successfully created"
    click_on "Back"
  end

  test "updating a Telegram" do
    visit telegrams_url
    click_on "Edit", match: :first

    fill_in "Article", with: @telegram.article_id
    fill_in "Author", with: @telegram.author
    fill_in "Description", with: @telegram.description
    fill_in "Title", with: @telegram.title
    click_on "Update Telegram"

    assert_text "Telegram was successfully updated"
    click_on "Back"
  end

  test "destroying a Telegram" do
    visit telegrams_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Telegram was successfully destroyed"
  end
end
