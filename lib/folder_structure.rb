require 'fileutils'

class FolderStructure
  
  def create_folder(folder_name)
    FileUtils.mkdir_p(folder_name) unless File.exists?(folder_name)
  end
  
  def create_back_up(old_folder_name, parent_folder_name = '')
    parent_folder_name = parent_folder_name + '/' unless parent_folder_name[-1, 1] == '/'

    #Create the test history folder name
    test_history_folder_name = rename_latest_filename_to_test_history(old_folder_name.dup, parent_folder_name)
    #If a parent folder has been supplied then add it to the path
    old_folder_name = parent_folder_name + old_folder_name

    #Move the old folder to the new folder
    FileUtils.mv(old_folder_name, test_history_folder_name)
  end
  
  def populate_folders(grandparent, parent, child)
    child.each { |folder|
      create_folder(grandparent + '/' + parent)
      create_folder(grandparent + '/' + parent + '/' + folder)
    }
  end

  def rename_latest_filename_to_test_history(latest_file_name, parent_folder_name = '')
    latest_file_name.slice!('Latest')
    latest_file_name.insert(0, parent_folder_name + 'Test History')

    return latest_file_name
  end

end

