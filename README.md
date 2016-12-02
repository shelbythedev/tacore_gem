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
require 'tacore'

TACore.configure do |config|
  config.api_url = "https://api.thinaer.io/v2"
  config.client_id = ""
  config.client_secret = ""
  config.api_key = ""
end

TACORE_TOKEN = TACore::Auth.login["token"]
```

### Examples
Find a Client {TACore::Client.find}

```
client = TACore::Client.find(TACORE_TOKEN, "ad62b2ffd21aed09b1ba0d3")

client["_id"]  => 3122
client["name"]  => "My Client"
```


## Support

Please use the github ticket system to request support for this GEM.