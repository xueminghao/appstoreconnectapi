require 'test_helper'

class DeviceTest < Minitest::Test
    def test_list_devices
        assert Asca::Devices.list_devices
    end
    
    def test_register_new_device
        Asca::Devices.register_new_device "00008030-001E2C1C3480802E", "test_register_new_device"
    end
end