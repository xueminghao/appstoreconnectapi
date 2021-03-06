require "test_helper"

class AscaTest < Minitest::Test
    def test_update_config
        assert Asca::Tools::Configuration.update_config "foo","bar"
        assert Asca::Tools::Configuration.update_config "foo2",100
        assert Asca::Tools::Configuration.update_config "foo2",nil
    end

    def test_new_token
        token = Asca::Tools::Token.new_token
        assert token
    end
end