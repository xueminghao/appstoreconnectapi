import 'http'

module Asca
    class Bundleids
        class << self
            def list_bundle_ids
                response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(URI_BUNDLEIDS)
                if response.status.success?
                    bundleids = JSON.parse(response.body)
                    puts "Devices count: #{bundleids}"
                end
                return response.status.success?
            end
        end
    end
end