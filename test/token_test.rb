require "test_helper"

class AscaTest < Minitest::Test
    def test_update_config
        assert Asca::Token.update_config "foo","bar"
        assert Asca::Token.update_config "foo2",100
        assert Asca::Token.update_config "foo2",nil
    end

    def test_new_token
        token = Asca::Token.new_token
        assert token
    end
end