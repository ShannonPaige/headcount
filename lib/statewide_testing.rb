class StatewideTesting
  attr_accessor :district_name, :data, :race_table

  def initialize(district_name, data)
    # An instance this class can be initialized by supplying the name of the
    #district which is then used to find the matching data in the data files.
    @district_name = district_name
    @data = data
    @race_table = {:asian => "Asian", :black => "Black",
      :pacific_islander => "Hawaiian/Pacific Islander",
      :hispanic => "Hispanic", :native_american => "Native American",
      :two_or_more => "Two or more", :white => "White"}
  end

  def race_lookup(race)
      race_table[race]
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
    if !race_lookup(race)
      raise UnknownRaceError
    end
    expected ||= {}
    proficiency_data = [
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__math],
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__reading],
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__writing],
    ]
    counter = 0
    proficiency_data.each do |csap_results|
      if counter == 0
        subject = :math
      elsif counter == 1
        subject = :reading
      else
        subject = :writing
      end
      csap_results.each do |year, hash|
        expected[year] ||= {}
        expected[year][subject] ||= {}
        expected[year][subject] = csap_results[year][race_lookup(race)]
      end
      counter += 1
    end
    expected
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    # This method take three parameters:

    #subject as a symbol from the following set: [:math, :reading, :writing]
    #race as a symbol from the following set: [:asian, :black, :pacific_islander, :hispanic, :native_american, :two_or_more, :white]
    #year as an integer for any year reported in the data
    #A call to this method with any invalid parameter (like subject of :history) should raise a UnknownDataError.

    #The method returns a truncated three-digit floating point number representing a percentage.
    #doesn't work - have to read in data that sorts by year-> race-> subject
    if year == 3
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap][year][race_lookup(race)]
    elsif year == 8
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap][year][race_lookup(race)]
    else
      raise UnknownDataError
    end

  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)

    case subject
    when (:math)
      new_hash = data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
      new_hash[year][subject].round(3)
    when (:reading)
      new_hash = data[:eightth_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
      new_hash[year][subject].round(3)
    when (:writing)

    else
      raise UnknownDataError

    end
  end

  def proficient_for_subject_in_year(subject, year)
    # This method take two parameters:

    #subject as a symbol from the following set: [:math, :reading, :writing]
    #year as an integer for any year reported in the data
    #A call to this method with any invalid parameter (like subject of :history) should raise a UnknownDataError.

    #The method returns a truncated three-digit floating point number representing a percentage.
  end
end
