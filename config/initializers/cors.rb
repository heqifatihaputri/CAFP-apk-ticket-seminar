# Rack CORS configuration
Rails.application.config.hosts = [
  IPAddr.new("0.0.0.0/0"), # All IPv4 addresses.
  IPAddr.new("::/0"),      # All IPv6 addresses.
  "localhost"              # The localhost reserved domain.
]
# Rails.application.config.hosts << Rails.application.secrets.default_mailer_url.gsub("https://", "")
# Rails.application.config.hosts << Rails.application.secrets.default_mailer_url.gsub("http://", "")
# Rails.application.config.hosts << nil

# Rails.application.config.hosts << "staging.tqg2u.my" if Rails.env.staging?
# if Rails.env.production?
#   Rails.application.config.hosts << "prod.tqg2u.my" 
#   Rails.application.config.hosts << "www.tqg2u.my"
#   Rails.application.config.hosts << "tqg2u.my"
# end

# origins "#{Rails.application.secrets.default_mailer_url}"
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [
        :get, :post, :put, :patch, :delete, :options, :head,
        'get', 'post', 'put', 'patch', 'delete', 'options', 'head'
      ]
  end
end