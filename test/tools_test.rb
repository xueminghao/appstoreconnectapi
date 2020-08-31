require "test_helper"

class ToolsTest < Minitest::Test
    def test_register_device
        Asca::Tools.register_device :device_info => { :udid => "00008030-000E49261A29802E", :name => "hu meifang's new iphoe" }, :profile_names => [ 'test-debug' ]
    end
end