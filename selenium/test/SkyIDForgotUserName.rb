require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class EmailSent < Test::Unit::TestCase

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
  
  def test_email_sent
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @driver.find_element(:id, "forgottenUsername").click
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | ForgotUsername.jpg | ]]
    @driver.save_screenshot('ForgotUsername.jpg');

    @driver.find_element(:id, "forgotUsernameEmail").clear
    @driver.find_element(:id, "forgotUsernameEmail").send_keys "hannahsearle@gmail.com"
    @driver.find_element(:id, "emailSubmitButton").click
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | EmailSent.jpg | ]]
    @driver.save_screenshot('EmailSent.jpg');

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
