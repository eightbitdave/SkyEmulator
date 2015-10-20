require 'json'
require 'selenium-webdriver'
require 'test-unit'
load '../selenium/base/login_base.rb'

class MySettingsLoggedIn < Test::Unit::TestCase

  @@login = MySettingsLoggedInBase.new

  def setup
    @@login.setup()
    @verification_errors = []
  end

  def teardown
    @@login.teardown
    assert_equal [], @verification_errors
  end

  def test_my_settings_logged_in
    @@login.test_my_settings_logged_in
  end

  def element_present?(how, what)
    receiver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def alert_present?
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
    alert = receiver.switch_to.alert
    alert_text = alert.text
    if @accept_next_alert
      alert.accept
    else
      alert.dismiss
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
