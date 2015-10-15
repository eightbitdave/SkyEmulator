require 'test/unit'
require 'fileutils'
require 'folder_structure'

class TestFolderStructure < Test::Unit::TestCase
  
  def setup
    @fs = FolderStructure.new()
    @folder_name = "test_folder"
    @fake_folders = ["foo", "bar", "foobar"]
  end
  
  def test_latest_exists
    @fs.create_folder(@folder_name)
    assert(File.directory?(@folder_name)) 
  end
  
  def test_back_up_created
    @fs.create_folder(@folder_name)
    @fs.create_back_up(@folder_name)
    assert(File.directory?(@folder_name))
  end
  
  def test_populate_folders
    @fs.create_folder(@folder_name)
    @fs.create_folder(@folder_name + "/Latest")
    @fs.populate_folders(@folder_name, "/Latest", @fake_folders)
    @fake_folders.each { |folder|
      assert(File.directory?(@folder_name + "/Latest/" + folder))
    }
  end
  
  def teardown
    FileUtils.rm_rf(@folder_name)
    #FileUtils.rm_rf() delete test history future feature
  end

end