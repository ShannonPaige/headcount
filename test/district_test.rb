require "district"

class DistrictTest < Minitest::Test

  def setup
    @dr = DistrictRepositoryTest.make_repository
    @district = @dr.find_by_name("ACADEMY 20")
  end

  def test_returns_the_upcased_string_name_of_the_district
    #assert_equal "ACADEMY 20", @dr."academy 20".name
    assert_equal 'COLORADO', @dr.find_by_name('colorado').name
  end
end
