Recaptcha.configure do |config|
  config.skip_verify_env = ['test', 'development']
  config.site_key = ENV['RECAPTCHA_SITE_KEY'] || 'dummy'
  config.secret_key = ENV['RECAPTCHA_SECRET_KEY'] || 'dummy'
end