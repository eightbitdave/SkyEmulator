

class HomeController < ApplicationController
  def index
  end

  def script
    load 'file_sort.rb'
    SummaryMailer.test_email.deliver_now
    
    render :text => "hello"
  end
end
