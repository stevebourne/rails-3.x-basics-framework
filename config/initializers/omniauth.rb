Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 'APP_KEY', 'APP_SECRET'
end