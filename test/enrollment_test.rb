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

  def test_returns_dropout_rate_in_given_year
    assert_equal 0.002, @enrollment_instance.dropout_rate_in_year(2011)
  end

  def test_returns_dropout_rate_by_gender_in_given_year
    skip
    expected = {:female => 0.002, :male => 0.002}
    assert_equal expected, @enrollment_instance.dropout_rate_by_gender_in_year(2012)
  end

  def test_returns_hash_of_dropout_rate_by_race_in_year
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
  end

  def test_returns_dropout_hash_by_year_distributed_by_race
    skip
    expected = {
      2011 => 0.047,
      2012 => 0.041
    }
    assert_equal expected, @enrollment_instance.dropout_rate_for_race_or_ethnicity(:asian)
  end

  def enddropout_rate_for_race_or_ethnicity_in_year(race, year)
    skip
    assert_equal 0.001, @enrollment_instance.dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
  end

  def graduation_rate_by_year
    skip
    expected = {2010 => 0.895,
      2011 => 0.895,
      2012 => 0.889,
      2013 => 0.913,
      2014 => 0.898,
    }
    assert_equal expected, @enrollment_instance.graduation_rate_by_year
  end

  def graduation_rate_in_year(year)

  # year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a truncated three-digit floating point number representing
  #a percentage.
  end



  def kindergarten_participation_by_year

  #This method returns a hash with years as keys and a truncated three-digit
  #floating point number representing a percentage.

  end

  def kindergarten_participation_in_year(year)

  #This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a truncated three-digit floating point number representing
  # a percentage.
  end

  def online_participation_by_year

  #This method returns a hash with years as keys and an integer as the value.
  end

  def online_participation_in_year(year)

  #This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a single integer.
  end



  def participation_by_year

  # This method returns a hash with years as keys and an integer as the value.
  end

  def participation_in_year(year)

  # This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a single integer.
  end

  def participation_by_race_or_ethnicity(race)

  # This method takes one parameter:

  #race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
  #A call to this method with any unknown race should raise an UnknownRaceError.

  #The method returns a hash with years as keys and a three-digit floating point number representing a percentage.
  end

  def participation_by_race_or_ethnicity_in_year(year)

  # This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a hash with race markers as keys and a three-digit floating point number representing a percentage.
  end

  def special_education_by_year

  # This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.
  end

  def special_education_in_year(year)

  #This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a single three-digit floating point percentage.
  end
  def remediation_by_year

  #This method returns a hash with years as keys and an floating point three-significant digits representing a percentage.
  end

  def remediation_in_year(year)

  # This method takes one parameter:

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a single three-digit floating point percentage.
  end
end
