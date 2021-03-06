# encoding: utf-8

require 'spec_helper'

RSpec.describe "crumbs routing" do
  include ActionView::TestCase::Behavior

  it "doens't show empty breadcrumbs" do
    visit root_path
    expect(page).to_not have_content("breadcrumbs")
  end

  it "inherits controller breadcrumb and adds index action breadcrumb" do
    visit posts_path
    within '#breadcrumbs' do
      expect(page.html).to include('<a href="/">Home</a>')
      expect(page.html).to include('<a href="/posts">All Posts</a>')
    end
  end

  it 'filters out controller breadcrumb and adds new action breadcrumb' do
    visit new_post_path
    within '#breadcrumbs' do
      expect(page).to_not have_content('Home')
      expect(page).to have_content('New Post')
    end
  end

  it "adds breadcrumb in view with path variable" do
    visit post_path(1)
    within '#breadcrumbs' do
      expect(page.html).to include('<a href="/posts/1">Show Post in view</a>')
    end
  end

  it 'should be current when forced' do
    visit new_post_path
    click_button "Create"

    expect(page.current_path).to eq(posts_path)
    within '#breadcrumbs' do
      expect(page).to have_content('New Post')
      expect(page).to have_selector('.selected')
    end
  end
end
