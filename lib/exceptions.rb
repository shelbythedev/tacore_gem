module TACore
  class AuthenticationError < StandardError; end

  # => TokenError is presented when the access token is no longer valid or there was a communication issue.
  # Error, Token expired or external API is not responding.
  class TokenError < AuthenticationError; end

  class NotThereError < StandardError; end
end
