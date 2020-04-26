require "rails_helper"

feature "Posting" do
  given(:user) { create(:user) }
  given(:status_text) { "Whohoo!" }

  def sign_in(user)
    visit new_user_session_path
    fill_in "Username / Email", with: user.username
    fill_in "Password", with: user.password
    click_on "Log in"
  end

  scenario "Posting a status" do
    sign_in user

    expect {
      fill_in "post_status_text", with: status_text
      click_on "Say"
    }.to change { user.reload.posts.count }.from(0).to(1)

    posted_status = user.posts.first.postable
    expect(posted_status.text).to eq status_text
    expect(page).to have_content status_text

    within(".line .content") do
      expect(page).not_to have_selector("img")
    end
  end

  scenario "Posting a status with a picture" do
    sign_in user

    expect {
      fill_in "post_status_text", with: status_text
      attach_file "picture_files", Rails.root.join("lgtm.png"), visible: false
      click_on "Say"
    }.to change { user.reload.posts.count }.from(0).to(1)

    expect(page).to have_content status_text

    within(".line .content") do
      expect(page).to have_selector(".pictures")
      expect(page).to have_selector("img", count: 1)
    end
  end

  scenario "Posting a status with multipe pictures" do
    sign_in user

    expect {
      fill_in "post_status_text", with: status_text
      attach_file "picture_files", [
        Rails.root.join("lgtm.png"),
        Rails.root.join("lgtm2.gif")
      ], visible: false
      click_on "Say"
    }.to change { user.reload.posts.count }.from(0).to(1)

    within(".line .content") do
      expect(page).to have_selector("img", count: 2)
    end
  end
end
