class SummaryMailer < ApplicationMailer
  default from: 'donotreply@sky.uk'

  def test_email
    mail(to: 'ronanm@gmail.com', subject: 'Emulator: change summary.')
  end
end