require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class ChangeTvPin < Test::Unit::TestCase

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @base_url = "http://www.sky.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_change_tv_pin
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @driver.find_element(:id, "username").clear
    @driver.find_element(:id, "username").send_keys "webadmtest2000"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "test1234"
    @driver.find_element(:id, "signinButton").click

    el = @driver.find_element(:id, "skycom-my-sky")
    @driver.action.move_to(el).perform

    @driver.find_element(:link, "TV PIN").click
    @driver.save_screenshot('updateTVPin.jpg');

    @driver.find_element(:name, "pin").send_keys "2321"
    @driver.find_element(:name, "confirm-pin").send_keys "1234"
    @driver.find_element(:id, "tv_pin_button").click
    @driver.save_screenshot('updatePinError.jpg');


    @driver.find_element(:name, "pin").clear
    @driver.find_element(:name, "pin").send_keys "1234"
    @driver.find_element(:name, "confirm-pin").clear
    @driver.find_element(:name, "confirm-pin").send_keys "1234"
    @driver.find_element(:id, "tv_pin_button").click

    @driver.manage.timeouts.implicit_wait = 3000
    @driver.save_screenshot('updatePinSuccess.jpg');
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
