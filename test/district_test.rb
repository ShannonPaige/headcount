require "district"

class DistrictTest < Minitest::Test

  def setup
    @dr ||= DistrictRepository.from_csv(data_dir)
    @district = @dr.find_by_name("ACADEMY 20")
  end

  def data_dir
    File.expand_path '../data', __dir__
  end

  def test_returns_the_upcased_string_name_of_the_district
    #assert_equal "ACADEMY 20", @dr."academy 20".name
  end
end
