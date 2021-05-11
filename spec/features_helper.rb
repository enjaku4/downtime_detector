# Require this file for feature tests
require_relative './spec_helper'

RSpec.configure do |config|
  config.include RSpec::FeatureExampleGroup
end
