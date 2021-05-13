Recaptcha.configure do |config|
  config.skip_verify_env = ['test', 'development']
end