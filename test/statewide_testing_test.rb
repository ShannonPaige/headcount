require "statewide_testing"

class StatewideTestingTest < Minitest::Test
  def setup
    @dr = DistrictRepository.load_from_csv(data_dir)
    @district = @dr.find_by_name("ACADEMY 20")
    @statewide_testing_instance = @district.statewide_testing
  end

  def data_dir
    File.expand_path '../data', __dir__
  end

  def test_returns_a_hash_grouped_by_year
    skip
  end

  def test_returns_a_hash_grouped_by_race
    skip
  end

  def test_returns_a_truncated_three_digit_floating_point_number_representing_a_percentage
    skip
  end

end
