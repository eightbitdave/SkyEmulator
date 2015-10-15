require 'fileutils'

class FolderStructure
  
  def create_folder(folder_name)
    Dir.mkdir(folder_name) unless File.exists?(folder_name)
  end
  
  def create_back_up(folder_name)
    date = Time.now
    
    FileUtils.mv(folder_name, "Test History - " + date.strftime("%Y-%m-%d %S"))
    #File.rename("Latest", "History - " + date.strftime("%Y-%m-%d %p"))
    
    create_folder(folder_name)
  end
  
  def populate_folders(grandparent, parent, child)
    child.each { |folder|
      create_folder(grandparent + "/" + parent)
      create_folder(grandparent + "/" + parent + "/" + folder)
    }
  end
  
end

