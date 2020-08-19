require 'json'
require 'jwt'

module Asca
    class Token
        EXPIRE_DURATION = 20 * 60
        class << self
            # Generate new jwt token.
            def new_token
                # get token from cache
                token = get_token_from_cache
                if token
                    return token
                end

                # get kid
                kid = Asca::Configuration.get_config('kid')
                if !kid
                    Asca::Log.info "Before generating a jwt token, please enter your kid:"
                    kid = gets.chomp
                    Asca::Configuration.update_config('kid', kid)
                end
                if !kid
                    Asca::Log.error "Error: no kid!"
                    return
                end

                # get issuer id
                iss = Asca::Configuration.get_config('iss')
                if !iss
                    Asca::Log.info "Before generating a jwt token, please enter your issuer id:"
                    iss = gets.chomp
                    Asca::Configuration.update_config('iss', iss)
                end
                if !iss
                    Asca::Log.error "Error: no issuer id!"
                    return
                end

                # get private key
                private_key = Asca::Configuration.get_config('private_key')
                if !private_key
                    Asca::Log.info "Before generating a jwt token, please enter your private key path:"
                    private_key_path = gets.chomp
                    private_key = File.read private_key_path
                    Asca::Configuration.update_config('private_key', private_key)
                end
                if !private_key
                    Asca::Log.error "Error: no private key!"
                    return
                end
                
                # generate jwt header
                jwt_header = {
                    "alg": "ES256",
                    "kid": kid,
                    "typ": "JWT"
                }

                # generate jwt payload
                exp = Time.now.to_i + EXPIRE_DURATION
                jwt_payload = {
                    "iss": iss,
                    "exp": exp,
                    "aud": "appstoreconnect-v1"
                }

                begin
                    es_key = OpenSSL::PKey::EC.new private_key
                rescue => exception
                    Asca::Log.info "Invalid private key, please enter your correct private key path:"
                    private_key_path = gets.chomp
                    private_key = File.read private_key_path
                    Asca::Configuration.update_config('private_key', private_key)
                    es_key = OpenSSL::PKey::EC.new private_key
                end

                token = JWT.encode jwt_payload, es_key, 'ES256', jwt_header
                Asca::Configuration.update_config('cache_token_time', exp)
                Asca::Configuration.update_config('cache_token', token)
                Asca::Log.info "==== New token generated ===="
                Asca::Log.info token
                Asca::Log.info "============================="
                return token
            end

            def get_token_from_cache
                token_valid_max_time = Asca::Configuration.get_config('cache_token_time')
                if !token_valid_max_time
                    return nil
                end
                current = Time.now.to_i
                if token_valid_max_time > current
                    return Asca::Configuration.get_config('cache_token')
                end
                return nil
            end
        end
    end
end