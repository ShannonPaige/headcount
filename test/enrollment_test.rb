require "enrollment"

class EnrollmentTest < Minitest::Test

  def setup
    @dr = DistrictRepository.load_from_csv(data_dir)
    @district = @dr.find_by_name("ACADEMY 20")
    @enrollment_instance = @district.enrollment
  end

  def data_dir
    File.expand_path '../data', __dir__
  end

  def test_returns_enrollment_number_in_a_given_year
    assert_equal 22620, @enrollment_instance.in_year(2009)
  end

  def test_returns_dropout_percent_in_given_year
    assert_equal 0.002, @enrollment_instance.dropout_rate_in_year(2011)
    assert_equal nil, @enrollment_instance.dropout_rate_in_year(1911)
  end

  def test_returns_dropout_rate_percents_by_gender_in_given_year
    skip
    expected = {:female => 0.002, :male => 0.002}
    assert_equal expected, @enrollment_instance.dropout_rate_by_gender_in_year(2012)
    assert_equal nil, @enrollment_instance.dropout_rate_by_gender_in_year(1912)
  end

  def test_returns_dropout_rate_percents_by_race_in_given_year
    skip
    expected = {
    :asian => 0.001,
    :black => 0.001,
    :pacific_islander => 0.001,
    :hispanic => 0.001,
    :native_american => 0.001,
    :two_or_more => 0.001,
    :white => 0.001
  }
    assert_equal expected, @enrollment_instance.dropout_rate_by_race_in_year(2012)
    assert_equal nil, @enrollment_instance.dropout_rate_by_race_in_year(1912)
  end

  def test_returns_dropout_rate_percents_by_year_for_given_race
    skip
    expected = {
      2011 => 0.047,
      2012 => 0.041
    }
    assert_equal expected, @enrollment_instance.dropout_rate_for_race_or_ethnicity(:asian)
    assert_equal UnknownRaceError, @enrollment_instance.dropout_rate_for_race_or_ethnicity(:wookiee)
  end

  def test_returns_dropout_rate_percent_for_given_race_and_year(race, year)
    skip
    assert_equal 0.001, @enrollment_instance.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
    assert_equal nil, @enrollment_instance.dropout_rate_for_race_or_ethnicity_in_year(:asian, 1912)
  end

  def test_returns_graduation_rate_percents_by_year
    skip
    expected = {2010 => 0.895,
      2011 => 0.895,
      2012 => 0.889,
      2013 => 0.913,
      2014 => 0.898,
    }
    assert_equal expected, @enrollment_instance.graduation_rate_by_year
  end

  def test_returns_graduation_rate_percent_in_given_year
    skip
    assert_equal 0.895, @enrollment_instance.graduation_rate_in_year(2010)
    assert_equal nil, @enrollment_instance.graduation_rate_in_year(1910)
  end

  def test_returns_kindergarten_participation_percents_by_year
    skip
    expected = {2010 => 0.391,
      2011 => 0.353,
      2012 => 0.267,
      2013 => 0.487,
      2014 => 0.490,
    }
    assert_equal expected, @enrollment_instance.kindergarten_participation_by_year
  end

  def test_returns_kindergarten_participation_percent_in_given_year
    skip
    assert_equal 0.391, @enrollment_instance.kindergarten_participation_in_year(2010)
    assert_equal nil, @enrollment_instance.kindergarten_participation_in_year(1910)
  end

  def test_returns_online_participation_numbers_by_year
    skip
    expected = {2010 => 16,
      2011 => 18,
      2012 => 24,
      2013 => 32,
      2014 => 40,
    }
    assert_equal expected, @enrollment_instance.online_participation_by_year
  end

  def test_returns_online_participation_number_in_given_year
    skip
    assert_equal 33, @enrollment_instance.online_participation_in_year(2013)
    assert_equal nil, @enrollment_instance.online_participation_in_year(1913)
  end

  def test_returns_participation_numbers_by_year
    skip
    expected = {2009 => 22620,
      2010 => 22620,
      2011 => 23119,
      2012 => 23657,
      2013 => 23973,
      2014 => 24578,
    }
    assert_equal expected, enrollment.participation_by_year
  end

  def test_returns_participation_number_in_given_year
    skip
    assert_equal 23973, enrollment.participation_in_year(2013)
    assert_equal nil, enrollment.participation_in_year(1913)
  end

  def test_returns_participation_percents_by_year_for_given_race
    skip
    expected = {
      2011 => 0.047,
      2012 => 0.041,
      2013 => 0.052,
      2014 => 0.056
    }
    assert_equal expected, @enrollment_instance.participation_by_race_or_ethnicity(:asian)
    assert_equal UnknownRaceError, @enrollment_instance.participation_by_race_or_ethnicity(:wookiee)
  end

  def test_returns_participation_percents_by_race_in_given_year
    skip
    expected = {
      :asian => 0.036,
      :black => 0.029,
      :pacific_islander => 0.118,
      :hispanic => 0.003,
      :native_american => 0.004,
      :two_or_more => 0.050,
      :white => 0.756
    }
    assert_equal expected, @enrollment_instance.participation_by_race_or_ethnicity_in_year(2012)
    assert_equal nil, @enrollment_instance.participation_by_race_or_ethnicity_in_year(1912)
  end

  def test_returns_special_education_participation_percents_by_year
    skip
    expected = {2009 => 0.075,
      2010 => 0.078,
      2011 => 0.072,
      2012 => 0.071,
      2013 => 0.070,
      2014 => 0.068,
    }
    assert_equal = expected, @enrollment_instance.participation_by_year
  end

  def test_returns_special_education_participation_percent_in_given_year
    skip
    assert_equal 0.105, @enrollment_instance.special_education_in_year(2013)
    assert_equal nil, @enrollment_instance.special_education_in_year(1913)
  end

  def remediation_by_year
    skip
    expected = {2009 => 0.232,
      2010 => 0.251,
      2011 => 0.278
    }
    assert_equal expected, @enrollment_instance.remediation_in_year
  #This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.
  end

  def remediation_in_year(year)

  # This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a single three-digit floating point percentage.
  end
end
