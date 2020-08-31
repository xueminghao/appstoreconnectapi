require 'http'
require 'json'

module Asca
    module REST
        module Provisioning
            class BundleIDs
                class << self
                    def list_bundle_ids
                        response = HTTP.auth('Bearer ' + Asca::Tools::Token.new_token).get(URI_BUNDLEIDS)
                        if response.status.success?
                            bundleids = JSON.parse(response.body)
                            return bundleids
                        else
                            puts response.body
                        end
                    end
                end
            end
        end
    end
end