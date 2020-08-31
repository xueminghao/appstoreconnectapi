require 'http'

module Asca
    module REST
        module Provisioning
            class Certificates
                class << self
                    def list_certificates(options = {})
                        # type enum : [ "DEVELOPMENT", "DISTRIBUTION" ]
                        type = options[:type]
                        types = !type ? "DEVELOPMENT, DISTRIBUTION" : type
                        response = HTTP.auth('Bearer ' + Asca::Tools::Token.new_token).get(URI_CERTIFICATES, :params => { 
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
    end
end