require 'airbrake'
require 'airbrake/rack'
require 'airbrake/sidekiq'

Airbrake.configure do |c|
  c.project_id = ENV['AIRBRAKE_PROJECT_ID']
  c.project_key = ENV['AIRBRAKE_API_KEY']
  c.environment = Hanami.env
  c.ignore_environments = ['development', 'test']
end

Airbrake.add_filter do |notice|
  if notice[:errors].any? { |error| error[:type] == 'SignalException' }
    notice.ignore!
  end
end
