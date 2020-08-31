require 'http'
require "json"

module Asca
    module Tools
        # register a new device and update corresponding profiles
        def self.register_device(options = {})
            device_info = options[:device_info]
            profile_names = options[:profile_names]
            if !device_info || !profile_names
                Asca::Tools::Log.error('Wrong parameters for register device')
                return
            end

            Asca::REST::Provisioning::Devices.register_new_device :udid => device_info[:udid], :name => device_info[:name]

            profile_names.each { |profile_name|
                Asca::REST::Provisioning::Profiles.update_profile :name => profile_name
            }
        end
    end
end