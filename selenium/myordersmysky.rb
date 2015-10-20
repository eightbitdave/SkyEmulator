require "json"
require "selenium-webdriver"
gem "test-unit"
require "test/unit"

class Myordersmysky < Test::Unit::TestCase

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
  
  def test_myordersmysky
    @driver.get(@base_url + "/")
    @driver.find_element(:link, "Sign In").click
    @driver.find_element(:id, "username").clear
    @driver.find_element(:id, "username").send_keys "webadmtest2000"
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys "test1234"
    @driver.find_element(:id, "signinButton").click

    el = @driver.find_element(:id, 'skycom-my-sky')
    @driver.action.move_to(el).perform
    @driver.find_element(:link, "My Orders").click
    @wait.until { @driver.page_source.include?("Added to your Sky package?")}
    @driver.save_screenshot("MyOrdersMain.jpg")


    el = @driver.find_element(:id, 'skycom-my-sky')
    @driver.action.move_to(el).perform
    @driver.find_element(:link, "Track my order").click
    @wait.until { @driver.page_source.include?("Added to your Sky package?")}
    @driver.save_screenshot("TrackOrder.jpg")


    el = @driver.find_element(:id, 'skycom-my-sky')
    @driver.action.move_to(el).perform
    @driver.find_element(:link, "Claim my reward").click
    @wait.until { @driver.find_element(:id, 'claim_vouchers').displayed?}
    @driver.save_screenshot("ClaimReward.jpg")

    el = @driver.find_element(:id, 'skycom-my-sky')
    @driver.action.move_to(el).perform
    @driver.find_element(:link, "Engineer visits").click
    @wait.until { @driver.page_source.include?("Added to your Sky package?")}
    @driver.save_screenshot("EngineerVisits.jpg")

    el = @driver.find_element(:id, 'skycom-my-sky')
    @driver.action.move_to(el).perform

    @driver.find_element(:link, "Set up viewing card").click
    @wait.until { @driver.find_element(:id, 'classic-step-1').displayed?}
    @driver.save_screenshot("SetUpViewingCard.jpg")
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
