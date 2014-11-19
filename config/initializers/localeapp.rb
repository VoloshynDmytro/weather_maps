require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = 'Acbwb5LPgM29uYSEI7zmMbwskTQF2x7yGLjentFwqPhnMajqW1'

# allow localeapp to check for new translations in production
  config.polling_environments << :production
# the number of seconds to wait between checking for new translations
# enter `0` to check on every request
  config.poll_interval = 60
# when new translations have been downloaded, reload I18n
  config.reloading_environments << :production
# send missing translations to Locale in production
  config.sending_environments << :production
end

if Rails.env.production?
  Localeapp::CLI::Pull.new.execute
end