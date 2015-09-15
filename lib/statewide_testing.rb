class StatewideTesting
  def initialize(district_name)
    # An instance this class can be initialized by supplying the name of the
    #district which is then used to find the matching data in the data files.
  end

  def proficient_by_grade(grade)
  # grade as an integer from the following set: [3, 4, 8]
  # A call to this method with an unknown grade should raise a UnknownDataError.

  # The method returns a hash grouped by year referencing percentages by subject
  #all as three digit floats.
  end

  def proficient_by_race_or_ethnicity(race)

  #This method takes one parameter:

  #race as a symbol from the following set: [:asian, :black, :pacific_islander,
  #:hispanic, :native_american, :two_or_more, :white]
  #A call to this method with an unknown race should raise a UnknownDataError.

  #The method returns a hash grouped by race referencing percentages by subject
  #all as truncated three digit floats.
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    # This method takes three parameters:

    # subject as a symbol from the following set: [:math, :reading, :writing]
    #grade as an integer from the following set: [3, 4, 8]
    #year as an integer for any year reported in the data
    # A call to this method with any invalid parameter (like subject of :science)
    #should raise a UnknownDataError.

    #The method returns a truncated three-digit floating point number representing
    #a percentage.
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    # This method take three parameters:

    #subject as a symbol from the following set: [:math, :reading, :writing]
    #race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    #year as an integer for any year reported in the data
    #A call to this method with any invalid parameter (like subject of :history) should raise a UnknownDataError.

    #The method returns a truncated three-digit floating point number representing a percentage.

  end

  def proficient_for_subject_in_year(subject, year)
    # This method take two parameters:

    #subject as a symbol from the following set: [:math, :reading, :writing]
    #year as an integer for any year reported in the data
    #A call to this method with any invalid parameter (like subject of :history) should raise a UnknownDataError.

    #The method returns a truncated three-digit floating point number representing a percentage.
  end
end
