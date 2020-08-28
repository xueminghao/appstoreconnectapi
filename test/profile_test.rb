require 'test_helper'

class AscaTest < Minitest::Test
  def test_download_profile
    Asca::Profiles.download_profile 'prime-ClubFactory-AdHoc', "~/Desktop"
    assert true
  end

  def test_create_new_profile
    Asca::Profiles.create_new_profile :name => 'test-debug', :type => 'IOS_APP_DEVELOPMENT', :bundle_id => '7R5XGBD6UV', :certificate_ids => ['4KBTC6PBF7'], :device_ids => ['2NFJQSPGCM']
  end

  def test_delete_profile
    Asca::Profiles.delete_profile :name => 'test-debug'
  end
end