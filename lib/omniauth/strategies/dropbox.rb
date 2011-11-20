require 'omniauth'

module OmniAuth
  module Strategies
    class Dropbox
      include OmniAuth::Strategy
      
      option :fields, [:name, :email]
      option :uid_field, :email
      
      def request_phase
        redirect client.auth_code.authorize_url({:redirect_uri => callback_url}.merge(options.authorize_params))
      end
      
      uid do
        request.params[options.uid_field]
      end

      info do
        options.fields.inject({}) do |hash, field|
          hash[field] = request.params[field]
          hash
        end
      end
      
    end
  end
end
