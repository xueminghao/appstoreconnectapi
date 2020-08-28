require 'test_helper'

class DeviceTest < Minitest::Test
    def test_list_devices
        assert Asca::Devices.list_devices
    end
    
    def test_register_new_device
        Asca::Devices.register_new_device "00008030-000E49261A29802E", "hu meifang's new iphoe"
    end
end