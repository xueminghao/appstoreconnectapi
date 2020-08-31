require 'test_helper'

class AscaTest < Minitest::Test
  i_suck_and_my_tests_are_order_dependent!

  def test_create_new_profile
    assert Asca::REST::Provisioning::Profiles.create_new_profile :name => 'test-debug', :type => 'IOS_APP_DEVELOPMENT', :bundle_id => '7R5XGBD6UV', :certificate_ids => ['4KBTC6PBF7'], :device_ids => ['2NFJQSPGCM']
  end

  def test_update_profile
    assert Asca::REST::Provisioning::Profiles.update_profile :name => 'test-debug'
  end

  def test_download_profile
    Asca::REST::Provisioning::Profiles.download_profile :name => 'test-debug', :out_put_dir => "~/Desktop"
    assert true
  end

end