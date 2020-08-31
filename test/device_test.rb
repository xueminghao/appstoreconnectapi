require 'test_helper'

class DeviceTest < Minitest::Test
    def test_list_devices
        assert Asca::REST::Provisioning::Devices.list_devices
    end
    
    def test_register_new_device
        Asca::REST::Provisioning::Devices.register_new_device :udid => "00008030-000E49261A29802E", :name => "hu meifang's new iphoe"
    end
end