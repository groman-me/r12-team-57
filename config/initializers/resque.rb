require 'resque/failure/multiple'
require 'resque/failure/redis'

rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

resque_config = YAML.load_file(rails_root.to_s + '/config/resque.yml')
Resque.redis = resque_config[rails_env]

Resque.after_fork do |_|
  ActiveRecord::Base.verify_active_connections!
end

failure_handlers = [Resque::Failure::Redis]
if defined? Exceptional
  Resque::Failure::Exceptional.configure do |config|
    config.api_key = YAML.load_file(rails_root.to_s + '/config/exceptional.yml')['api_key']
  end
  failure_handlers << Resque::Failure::Exceptional
end

Resque::Failure::Multiple.classes = failure_handlers
Resque::Failure.backend = Resque::Failure::Multiple
