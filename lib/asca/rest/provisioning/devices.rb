require 'http'
require "json"

module Asca
    module REST
        module Provisioning
            class Devices
                class << self
                    def list_devices
                        response = HTTP.auth('Bearer ' + Asca::Tools::Token.new_token).get(URI_DEVICES, :params => { "limit": 200 })
                        if response.status.success?
                            devices = JSON.parse(response.body)
                            puts "device count #{devices["data"].length()}"
                            return devices["data"]
                        end
                        return nil
                    end
        
                    def register_new_device(options = {})
                        udid = options[:udid] 
                        name = options[:name]
                        response = HTTP.auth('Bearer ' + Asca::Tools::Token.new_token).post(URI_DEVICES, :json => { "data" => {
                            "type" => "devices",
                            "attributes" => {
                                "name" => name,
                                "platform" => "IOS",
                                "udid" => udid
                            }
                        }})
                        if response.status.success?
                            return true
                        else
                            Asca::Tools::Log.error(response.body)
                            return false
                        end
                    end
                end
            end
        end
    end
end