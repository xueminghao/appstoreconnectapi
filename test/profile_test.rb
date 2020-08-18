require 'test_helper'

class AscaTest < Minitest::Test
  def test_request
    Asca::Profiles.download_profile 'prime-ClubFactory-AdHoc', "~/Desktop"
    assert true
  end
end