require 'json'
require 'jwt'
require 'fileutils'

module Asca
    class Token
        ROOTDIR = File.expand_path '~/.com.hurryup.asca'
        JSONFILE = File.expand_path 'config.json', ROOTDIR
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
                kid = get_config('kid')
                if !kid
                    puts "Before generating a jwt token, please enter your kid:"
                    kid = gets.chomp
                    update_config('kid', kid)
                end
                if !kid
                    puts "Error: no kid!"
                    return
                end

                # get issuer id
                iss = get_config('iss')
                if !iss
                    puts "Before generating a jwt token, please enter your issuer id:"
                    iss = gets.chomp
                    update_config('iss', iss)
                end
                if !iss
                    puts "Error: no issuer id!"
                    return
                end

                # get private key
                private_key = get_config('private_key')
                if !private_key
                    puts "Before generating a jwt token, please enter your private key path:"
                    private_key_path = gets.chomp
                    private_key = File.read private_key_path
                    update_config('private_key', private_key)
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
                update_config('cache_token_time', exp)
                update_config('cache_token', token)
                puts "==== New token generated ===="
                puts token
                puts "============================="
                return token
            end

            def get_token_from_cache
                cached_token_time = get_config('cache_token_time')
                if !cached_token_time
                    return nil
                end
                current = Time.now.to_i
                if cached_token_time - current > EXPIRE_DURATION
                    return nil
                end
                return get_config('cache_token')
            end

            # reset config file
            def reset_config
                # remove all
                FileUtils.rm_rf(ROOTDIR)

                # create root dir
                Dir.mkdir ROOTDIR

                # init config file
                File.open(JSONFILE, 'w') { |file|
                    file.write("{}")
                }
            end

            # update config
            def update_config(key, value)
                if !File.exist?(JSONFILE)
                    reset_config
                end
                file_content = File.read(JSONFILE)
                configuration = JSON.parse(file_content)
                if value
                    configuration[key] = value
                else
                    configuration.delete(key)
                end
                File.open(JSONFILE, 'w') { |file| 
                    file.write(JSON.pretty_generate(configuration))
                }
                return 0
            end
            
            def get_config(key)
                if !File.exist?(JSONFILE)
                    reset_config
                end
                file_content = File.read(JSONFILE)
                configuration = JSON.parse(file_content)
                return configuration[key]
            end
        end
    end
end