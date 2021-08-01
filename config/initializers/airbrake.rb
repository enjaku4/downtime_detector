if Hanami.env?(:production)
  require 'airbrake'
  require 'airbrake/rack'
  require 'airbrake/sidekiq'

  Airbrake.configure do |c|
    c.project_id = ENV.fetch('AIRBRAKE_PROJECT_ID')
    c.project_key = ENV.fetch('AIRBRAKE_API_KEY')
    c.environment = Hanami.env
  end
end