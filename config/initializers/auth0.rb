require 'omniauth/strategies/provider_1'
require 'omniauth/strategies/provider_2'

Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['PROVIDER_1_AUTH0_AUDIENCE'].blank?
    audience = URI::HTTPS.build(host: ENV['PROVIDER_1_AUTH0_DOMAIN'], path: '/userinfo').to_s
  else
    audience = ENV['PROVIDER_1_AUTH0_AUDIENCE']
  end

  provider(
    :provider1,
    ENV['PROVIDER_1_AUTH0_CLIENT_ID'],
    ENV['PROVIDER_1_AUTH0_CLIENT_SECRET'],
    ENV['PROVIDER_1_AUTH0_DOMAIN'],
    callback_path: ENV['PROVIDER_1_AUTH0_CALLBACK_URL'],
    authorize_params: {
        scope: 'openid profile email',
        audience: audience
    }
  )

  if ENV['PROVIDER_2_AUTH0_AUDIENCE'].blank?
    audience = URI::HTTPS.build(host: ENV['PROVIDER_2_AUTH0_DOMAIN'], path: '/userinfo').to_s
  else
    audience = ENV['PROVIDER_2_AUTH0_AUDIENCE']
  end

  provider(
      :provider2,
      ENV['PROVIDER_2_AUTH0_CLIENT_ID'],
      ENV['PROVIDER_2_AUTH0_CLIENT_SECRET'],
      ENV['PROVIDER_2_AUTH0_DOMAIN'],
      callback_path: ENV['PROVIDER_2_AUTH0_CALLBACK_URL'],
      authorize_params: {
          scope: 'openid profile email',
          audience: audience
      }
  )
end
