require 'fileutils'

class FolderStructure
  
  def create_folder(folder_name)
    FileUtils.mkdir_p(folder_name) unless File.exists?(folder_name)
  end
  
  def create_back_up(folder_name, parent_folder_name = '')
    date = Time.now
    new_folder_suffix = ''

    #if we have supplied a parent then create test folder in that
    new_folder_suffix = parent_folder_name + '/' unless parent_folder_name == ''

    FileUtils.mv(folder_name, new_folder_suffix + 'Test History - ' + date.strftime('%Y-%m-%d %S'))
    #File.rename("Latest", "History - " + date.strftime("%Y-%m-%d %p"))
    
    create_folder(folder_name)
  end
  
  def populate_folders(grandparent, parent, child)
    child.each { |folder|
      create_folder(grandparent + '/' + parent)
      create_folder(grandparent + '/' + parent + '/' + folder)
    }
  end

end

