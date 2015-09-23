require "headcount"

class Enrollment
  attr_accessor :district_name, :data, :race_table_dropout, :race_table_enrollment

  def initialize(district_name, data)
    @district_name = district_name
    @data = data
    @race_table_dropout = {:asian => "Asian Students", :black => "Black Students",
      :pacific_islander => "Native Hawaiian or Other Pacific Islander",
      :hispanic => "Hispanic Students", :native_american => "Native American Students",
      :two_or_more => "Two or More Races", :white => "White Students"}
    @race_table_enrollment = {:asian => "Asian Students", :black => "Black Students",
      :pacific_islander => "Native Hawaiian or Other Pacific Islander",
      :hispanic => "Hispanic Students", :native_american => "American Indian Students",
      :two_or_more => "Two or more races", :white => "White Students"}
  end

  def race_lookup_dropout(race)
      race_table_dropout[race]
  end

  def race_lookup_enrollment(race)
      race_table_enrollment[race]
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
    race_dropout = {}
    @race_table_dropout.each do |race_sym, race_s|
      race_dropout[race_sym] = data[:dropout_rates_by_race_and_ethnicity][race_s][year]
    end
    return nil if data[:dropout_rates_by_race_and_ethnicity]["Asian Students"][year] == nil
    race_dropout
  end

  def dropout_rate_for_race_or_ethnicity(race)
    if race_lookup_dropout(race)
      data[:dropout_rates_by_race_and_ethnicity][race_lookup_dropout(race)]
    else
      raise UnknownRaceError
    end
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
    if race_lookup_dropout(race)
      data[:dropout_rates_by_race_and_ethnicity][race_lookup_dropout(race)][year]
    else
      raise UnknownRaceError
    end
  end

  def graduation_rate_by_year
    data[:high_school_graduation_rates]
  end

  def graduation_rate_in_year(year)
    data[:high_school_graduation_rates][year]
  end

  def kindergarten_participation_by_year
    data[:kindergartners_in_full_day_program]
  end

  def kindergarten_participation_in_year(year)
    data[:kindergartners_in_full_day_program][year]
  end

  def online_participation_by_year
    data[:online_pupil_enrollment]
  end

  def online_participation_in_year(year)
    data[:online_pupil_enrollment][year]
  end

  def participation_by_year
    data[:pupil_enrollment]
  end

  def participation_in_year(year)
    data[:pupil_enrollment][year]
  end

  def participation_by_race_or_ethnicity(race)
    if race_lookup_enrollment(race)
      data[:pupil_enrollment_by_race_ethnicity][race_lookup_enrollment(race)][:percent]
    else
      raise UnknownRaceError
    end
  end

  def participation_by_race_or_ethnicity_in_year(year)
    race_participation = {}
    @race_table_enrollment.each do |race_sym, race_s|
      race_participation[race_sym] = data[:pupil_enrollment_by_race_ethnicity][race_s][:percent][year]
    end
    return nil if data[:dropout_rates_by_race_and_ethnicity]["Asian Students"][year] == nil
    race_participation
  end

  def special_education_by_year
    data[:special_education_by_percentage]
  end

  def special_education_in_year(year)
    data[:special_education_by_percentage][year]
  end

  def remediation_by_year
    data[:remediation_in_higher_education]
  end

  def remediation_in_year(year)
    data[:remediation_in_higher_education][year]
  end
end
