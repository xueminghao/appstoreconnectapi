require 'http'
require "json"

module Asca
    class Tools
        class << self
            # register a new device and update corresponding profiles
            def register_device(options = {})
                device_info = options[:device_info]
                profile_names = options[:profile_names]
                if !device_info || !profile_names
                    return
                end

                Asca::Devices.register_new_device :udid => device_info[:udid], :name => device_info[:name]

                # profile_names.each { |profile_name|
                #     Asca::Profiles.delete_profile :name => profile_name
                #     Asca::Profiles.create_new_profile :name => profile_name,
                # }
            end
        end
    end
end