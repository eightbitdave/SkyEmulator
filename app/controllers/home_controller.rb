

class HomeController < ApplicationController
  def index
  end

  def script
    load 'file_sort.rb'
    render :text => "hello"
  end
end
