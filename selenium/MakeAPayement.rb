require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class Viewmybill < Test::Unit::TestCase

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

  def test_viewmybill
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @driver.find_element(:id, "username").send_keys "webadmtest2000"
    @driver.find_element(:id, "password").send_keys "test1234"
    @driver.find_element(:id, "signinButton").click

    el = @driver.find_element(:id, "skycom-my-sky")
    @driver.action.move_to(el).perform

    @driver.find_element(:link, "Make a payment").click
    @wait.until { @driver.page_source.include?("Make a payment")  }

    @driver.switch_to.frame(0)

    @wait.until { @driver.page_source.include?("Payment amount (£)") }


    @driver.save_screenshot('MakeAPayment.png');

    @driver.find_element(:id, "make_payment_button").click
    @wait.until {  @driver.find_element(:xpath, "/html/body/form/div[2]/div[4]").displayed? }

    @driver.save_screenshot('MakeAPayementError.png');
    @driver.switch_to.default_content

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
