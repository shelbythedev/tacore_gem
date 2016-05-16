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
Create a new Client see {TACore::Client.create}

```
client = TACore::Client.find(TACORE_TOKEN, "ad62b2ffd21aed09b1ba0d3")

client["id"]  => 3122
client["name"]  => "My Client"
```
