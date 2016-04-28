module TACore
  class AuthenticationError < StandardError; end
  class TokenError < AuthenticationError; end
end
