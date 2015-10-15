require 'test_helper'

class ChangeNotifierTest < ActionMailer::TestCase
  test "change_summary" do
    mail = ChangeNotifier.change_summary
    assert_equal "Change summary", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
