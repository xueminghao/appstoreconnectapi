require 'test_helper'

class AscaTest < Minitest::Test
  def test_request_baidu
    Asca::Profiles.download_profile 'prime-ClubFactory-AdHoc', "~/Desktop"
    assert true
  end
end