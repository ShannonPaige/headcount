class Enrollment
  attr_accessor :district_name, :data

  def initialize(district_name, data)
    @district_name = district_name
    @data = data
  end

  def race_lookup(race)
    race_table = {:asian => "Asian Students", :black => "Black Students",
      :pacific_islander => "Native Hawaiian or Other Pacific Islander",
      :hispanic => "Hispanic Students", :native_american => "Native American Students",
      :two_or_more => "Two or More Races", :white => "White Students"}
      race_table[race]
    end


  def in_year(year)
    data[:pupil_enrollment][year]
  end

  def dropout_rate_in_year(year)
    data[:dropout_rates_by_race_and_ethnicity]["All Students"][year]
  end

  def dropout_rate_by_gender_in_year(year)
    gender_dropout = {}
    gender_dropout[:female] = data[:dropout_rates_by_race_and_ethnicity]["Female Students"][year]
    gender_dropout[:male] = data[:dropout_rates_by_race_and_ethnicity]["Male Students"][year]
    return nil if gender_dropout[:female] == nil
    gender_dropout
  end

  def dropout_rate_by_race_in_year(year)
    #data[:dropout_rates_by_race_and_ethnicity]["Female Students"][year]
  #year as an integer for any year reported in the data
  #A call to this method with any unknown year should return nil.

  #The method returns a hash with race markers as keys and a three-digit
  #floating point number representing a percentage.
  end

  def dropout_rate_for_race_or_ethnicity(race)
    data[:dropout_rates_by_race_and_ethnicity][race_lookup(race)]
    #needs UnknownRaceError
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    data[:dropout_rates_by_race_and_ethnicity][race_lookup(race)][year]
end

  def graduation_rate_by_year
    data[:high_school_graduation_rates]
  end

  def graduation_rate_in_year(year)
    data[:high_school_graduation_rates][year]
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
