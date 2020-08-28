require "test_helper"

class BundleidsTest < Minitest::Test
    def test_list_bundleids
        puts 'Request bundle ids'
        assert Asca::Bundleids.list_bundle_ids
    end
end