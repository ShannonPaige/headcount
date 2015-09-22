class StatewideTesting
  attr_accessor :district_name, :data, :race_table  # => nil

  def initialize(district_name, data)
    # An instance this class can be initialized by supplying the name of the
    #district which is then used to find the matching data in the data files.
    @district_name = district_name
    @data = data
    @race_table = {:asian => "Asian", :black => "Black",
      :pacific_islander => "Hawaiian/Pacific Islander",
      :hispanic => "Hispanic", :native_american => "Native American",
      :two_or_more => "Two or more", :white => "White"}
  end                                                                  # => :initialize

  def race_lookup(race)
      race_table[race]
  end                    # => :race_lookup

  def proficient_by_grade(grade)
    case grade
    when(3)
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
    when(8)
      data[:eightth_grade_students_scoring_proficient_or_above_on_the_csap_tcap]
    else
      raise UnknownDataError
    end
  end                                                                             # => :proficient_by_grade

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
  end                                                                          # => :proficient_by_race_or_ethnicity

  def proficient_for_subject_by_race_in_year(subject, race, year)
    case subject
    when (:math)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__math][year][race_lookup(race)]
    when (:reading)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__reading][year][race_lookup(race)]
    when (:writing)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__writing][year][race_lookup(race)]
    else
      raise UnknownDataError
    end
  end  # => :proficient_for_subject_by_race_in_year

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    #data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap][2008][:math]
    case subject
    when (:math)
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap][year][:math]
    when (:reading)
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap][year][:reading]
    when (:writing)
      data[:threerd_grade_students_scoring_proficient_or_above_on_the_csap_tcap][year][:writing]
    else
      raise UnknownDataError
    end
  end    # => :proficient_for_subject_by_grade_in_year

  def proficient_for_subject_in_year(subject, year)
    case subject
    when (:math)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__math][year]["All Students"]
    when (:reading)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__reading][year]["All Students"]
    when (:writing)
      data[:average_proficiency_on_the_csap_tcap_by_race_ethnicity__writing][year]["All Students"]
    else
      raise UnknownDataError
    end
  end  # => :proficient_for_subject_in_year
end    # => :proficient_for_subject_in_year
