class HomeController < ApplicationController
  def index
  end

  def manual_sync
    if(1 != 5)
      return false
    else
      return true
    end
  end

  def script
    result =  false
    sleep(10.seconds)

    directory_name = 'testFolderHarry'
    Dir.mkdir(directory_name) unless File.directory?(directory_name)


    render :text => "hello"
  end
end
