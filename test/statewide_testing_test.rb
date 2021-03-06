require "statewide_testing"
require "district_repository"

class StatewideTestingTest < Minitest::Test
  def setup
    @dr = DistrictRepositoryTest.make_repository
    @district = @dr.find_by_name("ACADEMY 20")
    @statewide_testing_instance = @district.statewide_testing
  end

  def test_proficient_by_grade
    expected = { 2008 => {:math => 0.857, :reading => 0.866, :writing => 0.671},
    2009 => {:math => 0.824, :reading => 0.862, :writing => 0.706},
    2010 => {:math => 0.849, :reading => 0.864, :writing => 0.662},
    2011 => {:math => 0.819, :reading => 0.867, :writing => 0.678},
    2012 => {:math => 0.830, :reading => 0.870, :writing => 0.655},
    2013 => {:math => 0.855, :reading => 0.859, :writing => 0.668},
    2014 => {:math => 0.834, :reading => 0.831, :writing => 0.639}}
    assert_equal expected, @statewide_testing_instance.proficient_by_grade(3)
    assert_raises UnknownDataError do
      @statewide_testing_instance.proficient_by_grade(72)
    end

  end

  def test_proficient_by_race_or_ethnicity
    expected = { 2011 => {math: 0.816, reading: 0.897, writing: 0.826},
    2012 => {math: 0.818, reading: 0.893, writing: 0.808},
    2013 => {math: 0.805, reading: 0.901, writing: 0.810},
    2014 => {math: 0.800, reading: 0.855, writing: 0.789},}
    assert_equal expected, @statewide_testing_instance.proficient_by_race_or_ethnicity(:asian)
    assert_raises UnknownDataError do
      @statewide_testing_instance.proficient_by_race_or_ethnicity(:aliens)
    end
  end

  def test_proficient_for_subject_by_grade_in_year
    assert_equal 0.857, @statewide_testing_instance.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
    assert_raises UnknownDataError do
      @statewide_testing_instance.proficient_for_subject_by_race_in_year(:organic_chemistry, 3, 2008)
    end
  end

  def test_proficient_for_subject_by_race_in_year
    assert_equal 0.818, @statewide_testing_instance.proficient_for_subject_by_race_in_year(:math, :asian, 2012)
    assert_raises UnknownDataError do
      @statewide_testing_instance.proficient_for_subject_by_race_in_year(:organic_chemistry, :asian, 2012)
    end
  end

  def test_proficient_for_subject_in_year
    assert_equal 0.689, @statewide_testing_instance.proficient_for_subject_in_year(:math, 2012)
    assert_raises UnknownDataError do
      @statewide_testing_instance.proficient_for_subject_in_year(:organic_chemistry, 2008)
    end
  end

  def test_returns_a_truncated_three_digit_floating_point_number_representing_a_percentage
    assert_equal 0.857, @statewide_testing_instance.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

end
