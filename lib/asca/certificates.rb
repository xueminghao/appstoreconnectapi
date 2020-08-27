require 'http'

module Asca
    class Certificates
        class << self
            def list_certificates(type = nil)
                # type enum : [ "DEVELOPMENT", "DISTRIBUTION" ]
                types = !type ? "DEVELOPMENT, DISTRIBUTION" : type
                response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(URI_CERTIFICATES, :params => { 
                    "filter[certificateType]" => types
                })
                if response.status.success?
                    certificates = JSON.parse(response.body)["data"]
                    for certificate in certificates do
                        id = certificate["id"]
                        name = certificate["attributes"]["name"]
                        type = certificate["attributes"]["certificateType"]
                        puts "Certificate id: #{id} name: #{name} type: #{type}"
                    end
                else 
                    puts response.body
                end
                return response.status.success?
            end
        end
    end
end