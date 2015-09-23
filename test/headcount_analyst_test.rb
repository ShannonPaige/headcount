require "headcount_analyst"

class HeadcountAnalystTest < Minitest::Test
  def setup
    @dr = DistrictRepository.from_csv(data_dir)
    @ha = HeadcountAnalyst.new(@dr)
  end

  def data_dir
    File.expand_path '../data', __dir__
  end

  #
  # def test_finds_a_single_statewide_leader_in_a_single_subject
  #   skip
  #   expected = 0.123
  #   assert_equal expected, @ha.top_statewide_testing_year_over_year_growth(:subject => :math)
  # end
  #
  # def test_finds_multiple_leaders_in_a_single_subject
  #   skip
  #   expected = [['top district name', growth_1],['second district name', growth_2],['third district name', growth_3]]
  #   assert_equal expected, @ha.top_statewide_testing_year_over_year_growth(:top => 3, :subject => :math)
  # end
  #
  # def test_finds_a_single_statewide_leader_in_multiple_subjects
  #   skip
  #   expected = ['the top district name', 0.111]
  #   assert_equal expected, @ha.top_statewide_testing_year_over_year_growth
  # end
  #
  # def test_finds_a_single_statewide_leader_in_multiple_subjects_with_weights
  #   skip
  #   expected = ['the top district name', 0.111]
  #   assert_equal expected, @ha.top_statewide_testing_year_over_year_growth(:weighting => {:math => 0.5, :reading => 0.5, :writing => 0.0})
  #   #TODO test that the weights add up to 1???
  # end

  def test_returns_how_a_districts_kindergarten_participation_rate_compares_to_the_state_average
    expected = 0.766
    assert_equal expected, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'state')
  end

  def test_returns_how_does_a_districts_kindergarten_participation_rate_compare_to_another_district
    expected = 0.572
    assert_equal expected, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ADAMS COUNTY 14')
    assert_equal 1.0, @ha.kindergarten_participation_rate_variation('ACADEMY 20', :against => 'ACADEMY 20')
  end

  def test_returns_how_kindergarten_participation_variation_compares_to_the_median_household_income_variation
    expected = 0.501
    assert_equal expected, @ha.kindergarten_participation_against_household_income('ACADEMY 20')
  end

  def test_returns_how_kindergarten_participation_correlates_with_median_household_income
    assert @ha.kindergarten_participation_correlates_with_household_income(:for => 'ACADEMY 20')
    assert @ha.kindergarten_participation_correlates_with_household_income(:for => 'state')
    #refute @ha.kindergarten_participation_correlates_with_household_income(:across => ['district_1', 'district_2', 'district_3', 'district_4'])
  end
  #
  # def test_returns_how_kindergarten_participation_variation_compares_to_high_school_graduation_variation
  #   expected = 1.2
  #   assert_equal expected, @ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
  # end
  #
  # def test_returns_correlation_between_kindergarten_participation_and_high_school_graduation
  #   assert @ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'district name')
  #   assert @ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'state')
  #   assert @ha.kindergarten_participation_correlates_with_high_school_graduation(:across => ['district_1', 'district_2', 'district_3', 'district_4'])
  # end
end
