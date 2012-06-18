class Voze::Application
  config.action_mailer.default_url_options = AppConfig.default_url_options.as_hash

  if AppConfig.mail[:smtp]
    config.action_mailer.delivery_method :smtp
    config.action_mailer.smtp_settings = AppConfig.mail.smtp.as_hash
  end
end