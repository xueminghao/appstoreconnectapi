require 'test_helper'

class AscaTest < Minitest::Test
  i_suck_and_my_tests_are_order_dependent!

  def test_create_new_profile
    assert Asca::Profiles.create_new_profile :name => 'test-debug', :type => 'IOS_APP_DEVELOPMENT', :bundle_id => '7R5XGBD6UV', :certificate_ids => ['4KBTC6PBF7'], :device_ids => ['2NFJQSPGCM']
  end

  def test_update_profile
    assert Asca::Profiles.update_profile :name => 'test-debug'
  end

  def test_download_profile
    Asca::Profiles.download_profile 'test-debug', "~/Desktop"
    assert true
  end

end