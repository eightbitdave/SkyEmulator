class ChangeNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.change_notifier.change_summary.subject
  #
  def change_summary
    @greeting = "Dear,"

    mail to: "to@example.org"
  end
end
