

class HomeController < ApplicationController
  def index
  end

  def script
    load 'selenium/login_loader.rb'
    render :text => 'hello'
  end
end
