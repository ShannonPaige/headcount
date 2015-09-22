class StatewideTesting
  attr_accessor :district_name, :data

  def initialize(district_name, data)
    # An instance this class can be initialized by supplying the name of the
    #district which is then used to find the matching data in the data files.
    @district_name = district_name
    @data = data
  end

  def proficient_by_grade(grade)
    case grade
    when(3)
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
    when(8)
      data[:eightth_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
    else
      raise UnknownDataError
    end
  end

  def proficient_by_race_or_ethnicity(race)
    #This method takes one parameter:

    #race as a symbol from the following set: [:asian, :black, :pacific_islander,
    #:hispanic, :native_american, :two_or_more, :white]
    #A call to this method with an unknown race should raise a UnknownDataError.

    #The method returns a hash grouped by race referencing percentages by subject
    #all as truncated three digit floats.
    #[:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]

    case race
    when(:asian)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__math]["Asian"]
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__reading]["Asian"]
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__writing]["Asian"]
    when(:black)
      data[:eightth_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
    else
      raise UnknownRaceError
    end
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)

    case grade
    when 3
      new_hash = data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
      new_hash[year][subject].round(3)
    when 8
      new_hash = data[:eightth_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
      new_hash[year][subject].round(3)
    else
      raise UnknownDataError
    end
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
