require "district"

class DistrictTest < Minitest::Test

  def test_returns_the_upcased_string_name_of_the_district
    assert_equal "ACADEMY 20", District.name("academy 20")
  end
end
