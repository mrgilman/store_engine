require 'spec_helper'

describe "Shopping Cart Requests" do
  let!(:user) { Fabricate(:user) }
  let!(:product) { Fabricate(:product, :title => "iPod") }

  before(:each) do
    login_user_post("admin", "admin")
  end

  
  context "when I visit the shopping cart" do
    it "should show the logged in users' cart items " do
      user.shopping_cart = Fabricate(:shopping_cart)
      user.shopping_cart.add_item(product.id, 10)
      visit '/shopping_cart'
      find_link(product.title).visible? 
    end
  end

  context "when I add an item to the cart" do
    before(:each) do
      params = { :product => product.id, :cart_item => {:quantity => 10} }
      page.driver.put(shopping_cart_path(product), params) 
      visit '/shopping_cart'
    end

    it "should show the newly created item in the cart" do
      find_link(product.title).visible?
    end

    it "should show the quantity for the item" do

    end
  end
end

