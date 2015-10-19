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
latest_folder_name = "Latest"

#If the parent path has a name
if parent_folder_Name != ''
  if !File.exists?(parent_folder_Name)
    fs.create_folder(parent_folder_Name)
  end

  parent_folder_Name = 'Data' + '/'
end

new_path = parent_folder_Name + latest_folder_name

if File.exists?(new_path)
  fs.create_back_up(new_path, parent_folder_Name)
else
  fs.create_folder(new_path)
end

fs.populate_folders(new_path, "My Package", my_package_folder)
fs.populate_folders(new_path, "Bills and Payments", bills_and_payments_folder)
fs.populate_folders(new_path, "My Orders", my_orders_folder)
fs.populate_folders(new_path, "My Details", my_details_folder)
fs.populate_folders(new_path, "My Settings", my_settings_folder)
fs.populate_folders(new_path, "Upgrade", upgrade_folder)
