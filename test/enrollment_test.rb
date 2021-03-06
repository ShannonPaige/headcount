require "enrollment"
require "district_repository"

class EnrollmentTest < Minitest::Test
  def setup
    @dr = DistrictRepositoryTest.make_repository
    @district = @dr.find_by_name("ACADEMY 20")
    @enrollment_instance = @district.enrollment
  end

  def test_returns_enrollment_number_in_a_given_year
    assert_equal 22620, @enrollment_instance.in_year(2009)
  end

  def test_returns_dropout_percent_in_given_year
    assert_equal 0.002, @enrollment_instance.dropout_rate_in_year(2011)
    assert_nil @enrollment_instance.dropout_rate_in_year(1911)
  end

  def test_returns_dropout_rate_percents_by_gender_in_given_year
    expected = {:female => 0.002, :male => 0.002}
    assert_equal expected, @enrollment_instance.dropout_rate_by_gender_in_year(2011)
    assert_nil @enrollment_instance.dropout_rate_by_gender_in_year(1911)
  end

  def test_returns_dropout_rate_percents_by_race_in_given_year
    expected = {
    :asian => 0.007,
    :black => 0.002,
    :pacific_islander => 0,
    :hispanic => 0.006,
    :native_american => 0.036,
    :two_or_more => 0,
    :white => 0.004
  }
    assert_equal expected, @enrollment_instance.dropout_rate_by_race_in_year(2012)
    assert_nil @enrollment_instance.dropout_rate_by_race_in_year(1912)
  end

  def test_returns_dropout_rate_percents_by_year_for_given_race
    expected = {
      2011 => 0,
      2012 => 0.007
    }
    assert_equal expected, @enrollment_instance.dropout_rate_for_race_or_ethnicity(:asian)
    assert_raises UnknownRaceError do
      @enrollment_instance.dropout_rate_for_race_or_ethnicity(:wookiee)
    end
  end

  def test_returns_dropout_rate_percent_for_given_race_and_year
    assert_equal 0.007, @enrollment_instance.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
    assert_nil @enrollment_instance.dropout_rate_for_race_or_ethnicity_in_year(:asian, 1912)
  end

  def test_returns_graduation_rate_percents_by_year
    expected = {2010 => 0.895,
      2011 => 0.895,
      2012 => 0.889,
      2013 => 0.913,
      2014 => 0.898,
    }
    assert_equal expected, @enrollment_instance.graduation_rate_by_year
  end

  def test_returns_graduation_rate_percent_in_given_year
    assert_equal 0.895, @enrollment_instance.graduation_rate_in_year(2010)
    assert_nil @enrollment_instance.graduation_rate_in_year(1910)
  end

  def test_returns_kindergarten_participation_percents_by_year
    expected = {2004 => 0.302,
      2005 => 0.267,
      2006 => 0.353,
      2007 => 0.391,
      2008 => 0.384,
      2009 => 0.39,
      2010 => 0.436,
      2011 => 0.489,
      2012 => 0.478,
      2013 => 0.487,
      2014 => 0.490,
    }
    assert_equal expected, @enrollment_instance.kindergarten_participation_by_year
  end

  def test_returns_kindergarten_participation_percent_in_given_year
    assert_equal 0.436, @enrollment_instance.kindergarten_participation_in_year(2010)
    assert_nil @enrollment_instance.kindergarten_participation_in_year(1910)
  end

  def test_returns_online_participation_numbers_by_year
    expected = {2011 => 33,
      2012 => 35,
      2013 => 341,
    }
    assert_equal expected, @enrollment_instance.online_participation_by_year
  end

  def test_returns_online_participation_number_in_given_year
    assert_equal 33, @enrollment_instance.online_participation_in_year(2011)
    assert_nil @enrollment_instance.online_participation_in_year(1911)
  end

  def test_returns_participation_numbers_by_year
    expected = {2009 => 22620,
      2010 => 23119,
      2011 => 23657,
      2012 => 23973,
      2013 => 24481,
      2014 => 24578,
    }
    assert_equal expected, @enrollment_instance.participation_by_year
  end

  def test_returns_participation_number_in_given_year
    assert_equal 24481, @enrollment_instance.participation_in_year(2013)
    assert_nil @enrollment_instance.participation_in_year(1913)
  end

  def test_returns_participation_percents_by_year_for_given_race
    expected = {2007=>0.05, 2008=>0.054, 2009=>0.055, 2010=>0.04, 2011=>0.036, 2012=>0.038, 2013=>0.038, 2014=>0.037}
    assert_equal expected, @enrollment_instance.participation_by_race_or_ethnicity(:asian)
    assert_raises UnknownRaceError do
      @enrollment_instance.dropout_rate_for_race_or_ethnicity(:wookiee)
    end
  end

  def test_returns_participation_percents_by_race_in_given_year
    expected =
      {:asian=>0.038, :black=>0.031, :pacific_islander=>0.004, :hispanic=>0.121, :native_american=>0.004, :two_or_more=>0.053, :white=>0.75}
    assert_equal expected, @enrollment_instance.participation_by_race_or_ethnicity_in_year(2012)
    assert_nil @enrollment_instance.participation_by_race_or_ethnicity_in_year(1912)
  end

  def test_returns_special_education_participation_percents_by_year
    expected = {2009 => 0.075,
      2010 => 0.078,
      2011 => 0.079,
      2012 => 0.078,
      2013 => 0.079,
      2014 => 0.079,
    }
    assert_equal expected, @enrollment_instance.special_education_by_year
  end

  def test_returns_special_education_participation_percent_in_given_year
    assert_equal 0.079, @enrollment_instance.special_education_in_year(2011)
    assert_nil @enrollment_instance.special_education_in_year(1911)
  end

  def test_returns_remediation_percents_by_year
    expected = {2009 => 0.264,
      2010 => 0.294,
      2011 => 0.263
    }
    assert_equal expected, @enrollment_instance.remediation_by_year
  end

  def test_returns_remediation_percent_in_given_year
    assert_equal 0.294, @enrollment_instance.remediation_in_year(2010)
    assert_nil @enrollment_instance.remediation_in_year(1910)
  end
end
