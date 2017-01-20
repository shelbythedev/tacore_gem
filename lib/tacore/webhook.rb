module TACore
  # => Webhooks allow the THINaer API to push updated/new data to a callback you select.
  # => NOTE: As of 4.1.0 Webhooks are in the Alpha Stage
  # It is important to note Webhooks will act independently of any client or venue id's. This means that when the
  # API updates a record in it's own database regardless of the data changed it will send an update if the object belongs to your application ID
  # Webhook API Docs (https://documenter.getpostman.com/view/150459/thinaer/2PMs5i#webhook)
  class Webhook < Auth
    # Create a new Webhook under your Application.
    # @param token [String] Client Token after Authentication
    # @param webhook [Object] Webhook params
    # @note Webhook currently only accepts 'callback, encryption, dataType' (https://documenter.getpostman.com/view/150459/thinaer/2PMs5i#webhook)
    # @return [Object] in JSON format
    def self.create(token, webhook = {})
      request(:post, '/webhook', webhook, { "token": token })
    end

    # Find an already created Webhook by ID
    # @param token [String] Client Token after Authentication
    # @param webhook_id [Integer] The webhook ID returned from {Webhook.create}
    # @return [Object] in JSON format
    def self.find(token, webhook_id)
      request(:get, '/webhook/' + webhook_id.to_s, {}, { "token": token })
    end

    # Update an existing webhook by ID
    # @param webhook_id [Integer] The webhook ID returned from {Webhook.create} or {Webhook.find}
    # @param webhook [Object] Webhook params
    # @return [Object] in JSON format
    def self.update(token, webhook_id, webhook ={})
      request(:put, '/webhook/' + webhook_id.to_s, webhook, { "token": token })
    end

    # Delete a webhook by ID
    # @param webhook_id [Integer] The webhook ID returned from {Webhook.create} or {Webhook.find}
    # @return [Object] in JSON format (Object of the full Application)
    def self.delete(token, webhook_id)
      request(:delete, '/webhook/' + webhook_id.to_s, {}, { "token": token })
    end
  end
end