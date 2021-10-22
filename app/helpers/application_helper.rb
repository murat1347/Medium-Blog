module ApplicationHelper
  def welcome(email)
    splitted_email = email.split('@').first
    "Welcome #{splitted_email}"
  end
end
