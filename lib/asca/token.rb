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
                    puts "Before generating a jwt token, please enter your kid:"
                    kid = gets.chomp
                    Asca::Configuration.update_config('kid', kid)
                end
                if !kid
                    puts "Error: no kid!"
                    return
                end

                # get issuer id
                iss = Asca::Configuration.get_config('iss')
                if !iss
                    puts "Before generating a jwt token, please enter your issuer id:"
                    iss = gets.chomp
                    Asca::Configuration.update_config('iss', iss)
                end
                if !iss
                    puts "Error: no issuer id!"
                    return
                end

                # get private key
                private_key = Asca::Configuration.get_config('private_key')
                if !private_key
                    puts "Before generating a jwt token, please enter your private key path:"
                    private_key_path = gets.chomp
                    private_key = File.read private_key_path
                    Asca::Configuration.update_config('private_key', private_key)
                end
                if !private_key
                    puts "Error: no private key!"
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

                es_key = OpenSSL::PKey::EC.new private_key

                token = JWT.encode jwt_payload, es_key, 'ES256', jwt_header
                Asca::Configuration.update_config('cache_token_time', exp)
                Asca::Configuration.update_config('cache_token', token)
                puts "==== New token generated ===="
                puts token
                puts "============================="
                return token
            end

            def get_token_from_cache
                cached_token_time = Asca::Configuration.get_config('cache_token_time')
                if !cached_token_time
                    return nil
                end
                current = Time.now.to_i
                if cached_token_time - current > EXPIRE_DURATION
                    return nil
                end
                return Asca::Configuration.get_config('cache_token')
            end
        end
    end
end