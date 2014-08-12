require 'spec_helper'



feature 'shopping for products' do
  before do
    DatabaseCleaner.clean
  end

  def log_in(user)
    visit '/'
    click_link 'Login'
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'Login'
  end

  scenario 'Guest can view existing products' do
    author = Author.create!(first_name: 'Arthur', last_name: 'Radcliffe')
    publisher = Publisher.create!(name: 'Arthur Books', city: 'Denver')
    Product.create!(
      name: 'Test Book',
      hardcover_price_in_cents: 1000,
      softcover_price_in_cents: 800,
      description: 'This is a description',
      image_url: 'http://fc04.deviantart.net/fs70/f/2012/306/d/c/fahrenheit_451__movie_poster_by_trzytrzy-d5jrq21.jpg',
      published_date: '1/1/2010',
      author_id: author.id,
      publisher_id: publisher.id
    )

    visit '/'

      click_on 'Test Book'
      expect(page).to have_field 'review[body]'
      expect(page).to have_field 'review[rating]'

      fill_in 'review[body]', with: "This was the best book ever."
      fill_in 'review[rating]', with: 5
      click_on 'Submit Review'

      expect(page).to have_content "This was the best book ever."

    end
  end