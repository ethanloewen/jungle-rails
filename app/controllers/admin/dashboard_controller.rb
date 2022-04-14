class Admin::DashboardController < ApplicationController

  # authentication
  http_basic_authenticate_with :name => ENV['AUTH_USERNAME'], :password => ENV['AUTH_PASSWORD']

  def show
    @count = Product.count
    @categories = Category.count
  end
end
