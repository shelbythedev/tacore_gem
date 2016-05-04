# ThinAer Core API Gem

## Test install
```
TACore::Test.new
```

### Setup
```
TACore.configure do |config|
  if Rails.env.development?
    config.api_url = "http://cirrus_api.dev"
    config.client_id = ""
    config.client_secret = ""
  end
end

TACORE_TOKEN = TACore::Auth.login.token
```
