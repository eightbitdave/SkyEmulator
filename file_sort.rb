load 'lib/folder_structure.rb'

my_package_folder = []
bills_and_payments_folder = ["View my bill", "Make a payment", "Change payment due date", "Change payment method"]
my_orders_folder = ["Track my order", "Claim my reward", "Engineer visits", "Set up viewing card"]
my_details_folder = ["Change details", "Addiontional users", "Moving home"]
my_settings_folder = ["Tv Pin", "Sky go Pin", "Broadband shield", "Broadband pro"]
upgrade_folder = ["Offers", "Sky Box Sets", "HD", "Sports", "Movies", "Broadband & Talk", "Customise your package"]

fs = FolderStructure.new()

#Create parent folder
parent_folder_Name = "Data"
latest_folder_name = 'Latest - ' + Time.now.strftime("%F %T").to_s.to_str

#If the parent path has a name
if parent_folder_Name != ''
  fs.create_folder(parent_folder_Name) unless File.exists?(parent_folder_Name)
  parent_folder_Name = 'Data' + '/'
end

new_path = parent_folder_Name + latest_folder_name

Dir.chdir('Data/')
folders = Dir.glob('*').select{
    |f| File.directory? f unless !f.include?("Latest -")
}
Dir.chdir('../')

#If there is folder that starts with 'Latest -'
fs.create_back_up(folders[0], parent_folder_Name) unless !folders.any?

#If not create a new folder
fs.create_folder(new_path)

fs.populate_folders(new_path, "My Package", my_package_folder)
fs.populate_folders(new_path, "Bills and Payments", bills_and_payments_folder)
fs.populate_folders(new_path, "My Orders", my_orders_folder)
fs.populate_folders(new_path, "My Details", my_details_folder)
fs.populate_folders(new_path, "My Settings", my_settings_folder)
fs.populate_folders(new_path, "Upgrade", upgrade_folder)
