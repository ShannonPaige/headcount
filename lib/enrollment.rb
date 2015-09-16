require "district_repository"

class Enrollment
  attr_accessor :district_name, :data

  def initialize(district_name, data)
  # An instance this class can be initialized by supplying the name of the
  #district which is then used to find the matching data in the data files.
  @district_name = district_name
  @data = data
  end

  def in_year(year)
    data[6][:data]
    #go to repository and look up some data in this year
  end

  def dropout_rate_in_year(year)
  # year as an integer for any year reported in the data
  # A call to this method with any unknown year should return nil.

  # The method returns a truncated three-digit floating point number representing
  #a percentage.
  end

  def dropout_rate_by_gender_in_year(year)

  # This method takes one parameter:

  # year as an integer for any year reported in the data
  # A call to this method with any unknown year should return nil.

  #The method returns a hash with genders as keys and three-digit floating point
  #number representing a percentage.
  end

  def dropout_rate_by_race_in_year(year)

  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a hash with race markers as keys and a three-digit
  #floating point number representing a percentage.
  end

  def dropout_rate_for_race_or_ethnicity(race)

  #race as a symbol from the following set: [:asian, :black, :pacific_islander,
  #:hispanic, :native_american, :two_or_more, :white]
  #A call to this method with any unknown race should raise an UnknownRaceError.

  #The method returns a hash with years as keys and a three-digit floating point
  # number representing a percentage.
  end

  def enddropout_rate_for_race_or_ethnicity_in_year(race, year)
  # race as a symbol from the following set: [:asian, :black, :pacific_islander,
  #:hispanic, :native_american, :two_or_more, :white]
  # year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.
end

  def graduation_rate_by_year
    # method returns a hash with years as keys and a truncated three-digit
    #floating point number representing a percentage.
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
