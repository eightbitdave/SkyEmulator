

class HomeController < ApplicationController
  def index
  end

  def script
    load 'selenium/loader/login_loader.rb'
    render :text => 'hello'
  end
end
