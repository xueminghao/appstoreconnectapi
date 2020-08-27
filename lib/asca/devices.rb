require 'http'
require "json"

module Asca
    class Devices
        class << self
            def list_devices
                response = HTTP.auth('Bearer ' + Asca::Token.new_token).get(URI_DEVICES)
                if response.status.success?
                    devices = JSON.parse(response.body)
                    puts "Devices count: #{devices["data"].length()}"
                end
                return response.status.success?
            end

            def register_new_device(udid, device_name)
                response = HTTP.auth('Bearer ' + Asca::Token.new_token).post(URI_DEVICES, :json => { "data" => {
                    "type" => "devices",
                    "attributes" => {
                        "name" => device_name,
                        "platform" => "IOS",
                        "udid" => udid
                    }
                }})
                if response.status.success?
                    puts response.body
                    return true
                else
                    puts response.body
                    return false
                end
            end
        end
    end
end