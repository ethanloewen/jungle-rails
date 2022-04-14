require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click add to cart on a product" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    find('.btn-primary .fa-shopping-cart', match: :first).click
    expect(page).to have_content('My Cart (1)')
    #save_screenshot
  end
end
