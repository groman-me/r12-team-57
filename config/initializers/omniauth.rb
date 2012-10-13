OmniAuth.config.logger = Rails.logger

config = YAML.load_file(File.join(Rails.root, "config", "omniauth.yml"))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, config['twitter']['key'], config['twitter']['secret']
end