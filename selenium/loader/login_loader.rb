load 'selenium/base/login_base.rb'

login = MySettingsLoggedInBase.new

login.setup
login.test_my_settings_logged_in
login.teardown