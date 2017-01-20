# ThinAer Core API Gem (API v2)
THINaer helps connect the unconnected with Gateway positioning software, allowing developers to 
build proximity applications with the THINaer API.

https://documenter.getpostman.com/view/150459/thinaer/2PMs5i

## Install
```
gem 'TACore'
```

```
$> gem install TACore
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

## Documentation

### GEM Docs
http://www.rubydoc.info/github/thinaer/tacore_gem/

### API Docs (Including Postman download)
https://documenter.getpostman.com/view/150459/thinaer/2PMs5i

## Support

Please use the github ticket system to request support for this GEM.

# How to contribute to ThinAër GEM
Contributing to ThinAër is not only wanted but it is needed to to make sure it meets the needs for your project. We encourage you to submit new ideas that help move the GEM forward but also follow our simple guidelines. Below is information on how to submit a pull request with newly added information to ThinAër.


1. Get started by forking the repository to your own personal account.
2. Pull the project down to your local environment.
3. Make changes, that conform to our guidelines then commit them. Please make sure your commit messages are clear and explain the changes made.
4. Now submit a pull request and explain the changes you are making and why.
5. We will review and address any issues on the pull request.

Your pull request will be reviewed and confirmed that it meets our guidelines. Once complete your request will be merged into draft pending the next version release of the ThinAër specification.


## Guidelines
ThinAër was created to remove the complexities and reduce the overall amount of code required to start using the THINaer API. Cases can be presented via a GitHub issue to alter the primary API. Primary API cases take a review and can take a few weeks to accept or reject a proposed change, please be a thorough as possible when making this type of request.


* Changes must follow the THINaer API (https://documenter.getpostman.com/view/150459/thinaer/2PMs5i).
* Address shortcoming in the current code.
* May not include other API's.
* When using new GEM's they must be approved prior to the pull request.
* All changes must include documentation using YARD.
* Version updates will be made by owners only.


Before considering a change, please ask any questions you may have so that we may help you complete your project goal.