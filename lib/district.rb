require_relative "enrollment"

class District
  attr_accessor :district_name, :data

  def initialize(district_name, data)
    @district_name = district_name
    @data = data
  end

  def self.name(district_name)
    district_name.upcase
  end

  def statewide_testing
    files_used_in_statewidetesting = [:threerd_grade_students_scoring_proficient_or_above_on_the_CSAP_TCAP,
      :eightth_grade_students_scoring_proficient_or_above_on_the_CSAP_TCAP,
      :average_proficiency_on_the_CSAP_TCAP_by_race_ethnicity_Math,
      :average_proficiency_on_the_CSAP_TCAP_by_race_ethnicity_Reading,
      :average_proficiency_on_the_CSAP_TCAP_by_race_ethnicity_Writing]
    statewidetesting_data = data.select do |key, value|
      files_used_in_statewidetesting.include? key
    end
    StatewideTesting.new(district_name, statewidetesting_data)
  end

  def enrollment
    files_used_in_enrollment = [:dropout_rates_by_race_and_ethnicity, :high_school_graduation_rates,
      :kindergartners_in_full_day_program, :online_pupil_enrollment,
      :pupil_enrollment_by_race_ethnicity_by_percentage, :pupil_enrollment,
      :special_education, :remediation_in_higher_education]
    enrollment_data = data.select do |key, value|
      files_used_in_enrollment.include? key
    end
    Enrollment.new(district_name, enrollment_data)
  end
end
