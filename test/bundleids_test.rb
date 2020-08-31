require "test_helper"

class BundleidsTest < Minitest::Test
    def test_list_bundleids
        assert Asca::REST::Provisioning::BundleIDs.list_bundle_ids
    end
end