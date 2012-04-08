class Voze::Application
  config.action_mailer.default_url_options = Hash[AppConfig[:default_url_options].map { |k,v| [k.intern, v] }]

  if AppConfig[:smtp]
    config.action_mailer.delivery_method :smtp
    config.action_mailer.smtp_settings = Hash[AppConfig[:smtp].map { |k,v| [k.intern, v] }]
  end
end