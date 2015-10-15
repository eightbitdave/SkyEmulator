load 'lib/folder_structure.rb'


my_package_folder = []
bills_and_payments_folder = ["View my bill", "Make a payment", "Change payment due date", "Change payment method"]
my_orders_folder = ["Track my order", "Claim my reward", "Engineer visits", "Set up viewing card"]
my_details_folder = ["Change details", "Addiontional users", "Moving home"]
my_settings_folder = ["Tv Pin", "Sky go Pin", "Broadband shield", "Broadband pro"]
upgrade_folder = ["Offers", "Sky Box Sets", "HD", "Sports", "Movies", "Broadband & Talk", "Customise your package"]

fs = FolderStructure.new()

if File.exists?("Latest")
  fs.create_back_up("Latest")
else
  fs.create_folder("Latest")
end

fs.populate_folders("Latest", "My Package", my_package_folder)
fs.populate_folders("Latest", "Bills and Payments", bills_and_payments_folder)
fs.populate_folders("Latest", "My Orders", my_orders_folder)
fs.populate_folders("Latest", "My Details", my_details_folder)
fs.populate_folders("Latest", "My Settings", my_settings_folder)
fs.populate_folders("Latest", "Upgrade", upgrade_folder)