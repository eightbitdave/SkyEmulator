# Preview all emails at http://localhost:3000/rails/mailers/change_notifier
class ChangeNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/change_notifier/change_summary
  def change_summary
    ChangeNotifier.change_summary
  end

end
