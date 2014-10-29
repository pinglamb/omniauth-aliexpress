require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Aliexpress < OmniAuth::Strategies::OAuth2
      option :client_options, {
        site:          "https://gw.api.alibaba.com",
        authorize_url: "/auth/authorize.htm",
        # token_url:     "/openapi/http/1/system.oauth2/getToken/YOUR_APPKEY"
      }

      option :authorize_params, {
        site: 'aliexpress'
      }

      option :token_params, {
        grant_type: 'authorization_code',
        need_refresh_token: 'true',
        parse: :json
      }

      uid { raw_info[:uid] }

      info do
        raw_info
      end

      extra do
        { raw_info: raw_info }
      end

      def client
        options.client_options[:token_url] = "/openapi/http/1/system.oauth2/getToken/#{options.client_id}"
        ::OAuth2::Client.new(options.client_id, options.client_secret, deep_symbolize(options.client_options))
      end

      def request_phase
        options.authorize_params[:state] = SecureRandom.hex(24)
        options.authorize_params[:_aop_signature] = Digest::HMAC.hexdigest(client_params.sort.flatten.join.to_s, options[:client_secret].to_s, Digest::SHA1).upcase
        redirect client.authorize_url({client_id: options.client_id, redirect_uri: callback_url}.merge(authorize_params))
      end

      def client_params
        {
          client_id: options[:client_id],
          redirect_uri: callback_url,
          site: options.authorize_params[:site],
          state: options.authorize_params[:state]
        }
      end

      def authorize_params
        params = options.authorize_params.merge(options_for('authorize'))
        if OmniAuth.config.test_mode
          @env ||= {}
          @env['rack.session'] ||= {}
        end
        session['omniauth.state'] = params[:state]
        params
      end

      def raw_info
        @raw_info ||= {
          uid: access_token.params['resource_owner'],
          ali_id: access_token.params['aliId'],
          resource_owner: access_token.params['resource_owner']
        }
      end
    end
  end
end
