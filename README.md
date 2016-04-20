# ThinAer Core API Gem

## Test install
```
TACore::Test.new
```

### Setup
```
TACore.configure do |config|
  if Rails.env.development?
    config.api_url = "http://bluekloud_core.dev"
    config.admin_key = "7iy7!-8uh3@ugrhuh-0033j4"
  elsif Rails.env.staging?
    config.api_url = "http://bluekloud-core-beta.us-west-2.elasticbeanstalk.com"
    config.admin_key = "7iy7!-8uh3@ugrhuh-0033j4"
  end
end
```
