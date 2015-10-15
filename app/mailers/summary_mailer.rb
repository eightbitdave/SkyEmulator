class SummaryMailer < ApplicationMailer
  default from: 'ronan.spoor@sky.uk'

  def test_email
    mail(to: 'ronanm@gmail.com', subject: 'test foobar')
  end
end
