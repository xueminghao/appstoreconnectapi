require "test_helper"

class AscaTest < Minitest::Test
    def test_init_config
        Asca::Token.init_config
        assert File.exist?(Asca::Token::ROOTDIR)
        assert File.exist?(Asca::Token::JSONFILE)
    end

    def test_update_config
        assert Asca::Token.update_config "foo","bar"
        assert Asca::Token.update_config "foo2",100
        assert Asca::Token.update_config "foo2",nil
    end
end