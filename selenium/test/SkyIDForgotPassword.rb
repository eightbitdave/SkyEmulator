require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class ForgotPassword < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://www.sky.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_forgot_password
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @driver.find_element(:id, "forgottenPassword").click
    @driver.find_element(:id, "resetPasswordLoginAlias").clear
    @driver.find_element(:id, "resetPasswordLoginAlias").send_keys "webadmtest2000"
    @driver.find_element(:id, "continueButton").click
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | forgotYourPass.jpg | ]]
    @driver.save_screenshot('forgotYourPass.jpg');

    @driver.find_element(:id, "pickedIdentificationMethod_securityqa").click
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | selectedSecurityQuestion.jpg | ]]
    @driver.save_screenshot('selectedSecurityQuestion.jpg');

    @driver.find_element(:id, "pickedIdentificationMethod_skyaccount").click
    # ERROR: Caught exception [ERROR: Unsupported command [captureEntirePageScreenshot | accountInformation.jpg | ]]
    @driver.save_screenshot('accountInformation.jpg');
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
