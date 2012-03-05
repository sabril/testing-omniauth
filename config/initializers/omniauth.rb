Rails.application.config.middleware.use OmniAuth::Builder do
  YAML.load_file(Rails.root.join("config", "omniauth.yml"))[Rails.env].each do |provider, *args|
    provider provider, *args
  end
end

OmniAuth.config.test_mode = Rails.env.test?
