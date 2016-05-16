# ThinAer Core API Gem

## Install
```
gem 'TACore'
```

## Test install
```
$> irb -r tacore
TACore::Test.new

This is a test of the TACore GEM
```

## Setup
```
TACore.configure do |config|
  config.api_url = "http://cirrus_api.dev"
  config.client_id = ""
  config.client_secret = ""
end

TACORE_TOKEN = TACore::Auth.login.token
```

### Examples
Create a new Client see {Client.create}
```
data = {name: "My Client"}
client = TACore::Client.create(TACORE_TOKEN, data)

client["id"] # => 3122
client["name"] # => "My Client"
```
