require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class MySettingsLoggedIn < Test::Unit::TestCase

  def setup

    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @driver.manage.window.maximize
    @base_url = "http://www.sky.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_my_settings_logged_in
    @driver.get(@base_url + "/")
    # wait for a specific element to show up
    @driver.save_screenshot('skyComNotLoggedIn.jpg')

    @driver.manage.timeouts.implicit_wait = 3000
    @driver.find_element(:link, "My Sky").click
    @wait.until { @driver.page_source.include?("Your Sky, your way") }
    @driver.save_screenshot('MySkyHomeNotLoggedIn.jpg');


    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @wait.until { @driver.page_source.include?("Sign in to Sky") }
    @driver.save_screenshot('LoginPage.jpg');


    @driver.find_element(:id, "username").clear
    @driver.find_element(:id, "username").send_keys "KATHY563"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "1234567"
    @driver.find_element(:id, "signinButton").click
    @wait.until { @driver.page_source.include?("Sorry, we did not recognise either your username or password") }
    @driver.save_screenshot('LoginPageError.jpg');


    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @driver.find_element(:id, "username").clear
    @driver.find_element(:id, "username").send_keys "webadmtest2000"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "test1234"
    @driver.find_element(:id, "signinButton").click
    last_picture = @driver.find_elements(:xpath, '/html/body/div[1]').last
    last_picture.location_once_scrolled_into_view
    @wait.until { @driver.find_element(:xpath, "/html/body/main/div/section[2]/div[1]").displayed? }
    @driver.save_screenshot('skyComLoggedIn.jpg');


    @driver.find_element(:link, "My Sky").click
    @wait.until { @driver.page_source.include?("621733426855") }
    @driver.save_screenshot('MySkyComLoggedIn.jpg');
    #
    # ERROR: Caught exception [ERROR: Unsupported command [mouseOver | link=My Sky | ]]
    el = @driver.find_element(:id, "skycom-my-sky")
    @driver.action.move_to(el).perform

    @driver.find_element(:link, "My Settings").click
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | ~\Desktop\MySettingsLoggedIn.jpg | ]]
    @wait.until { @driver.page_source.include?("621733426855") }
    @driver.save_screenshot('MySettingsLoggedIn.jpg');
  end

  def element_present?(how, what)
    receiver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?()
    receiver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end

  def verify(&blk)
    yield
  rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end

  def close_alert_and_get_its_text(how, what)
    alert = receiver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
