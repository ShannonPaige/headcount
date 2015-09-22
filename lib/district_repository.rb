require "csv"
require "district"
require "parse"
# require "pry"

class DistrictRepository
  include Parse
  attr_accessor :data, :districts

  def initialize(data)
    @data ||= data
    @districts = {}
    data.each do |district_name, hash|
      @districts[district_name] = District.new(district_name, data[district_name])
    end
  end

  def self.from_csv(data_dir)
    data_hash = {}
    Parse.parse_year_data_files(data_dir, data_hash, 'Pupil enrollment.csv')
    Parse.parse_year_data_files(data_dir, data_hash, 'Online pupil enrollment.csv')
    Parse.parse_year_data_files(data_dir, data_hash, 'High school graduation rates.csv')
    Parse.parse_year_data_files(data_dir, data_hash, 'Kindergartners in full-day program.csv')
    Parse.parse_year_data_files(data_dir, data_hash, 'Median household income.csv')
    Parse.parse_year_data_files(data_dir, data_hash, 'Remediation in higher education.csv')
    Parse.parse_year_data_files(data_dir, data_hash, 'Title I students.csv')
    Parse.parse_data_type_6(data_dir, data_hash, '3rd grade students scoring proficient or above on the CSAP_TCAP.csv')
    Parse.parse_data_type_6(data_dir, data_hash, '8th grade students scoring proficient or above on the CSAP_TCAP.csv')
    Parse.parse_data_type_7(data_dir, data_hash, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv')
    Parse.parse_data_type_7(data_dir, data_hash, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv')
    Parse.parse_data_type_7(data_dir, data_hash, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv')
    Parse.parse_info_year_data_files(data_dir, data_hash, 'Dropout rates by race and ethnicity.csv')
    Parse.parse_data_type_3(data_dir, data_hash, 'Special education.csv')
    Parse.parse_data_type_3(data_dir, data_hash, 'School-aged children in poverty.csv')
    Parse.parse_data_type_4(data_dir, data_hash, 'Pupil enrollment by race_ethnicity.csv')
    Parse.parse_data_type_5(data_dir, data_hash, 'Students qualifying for free or reduced price lunch.csv')
require "pry"; binding.pry
    DistrictRepository.new(data_hash)
  end

  def find_by_name(district_name)
    district_name = district_name.upcase
    @districts[district_name]
  end

  def find_all_matching(name_fragment)
    matching = []
    district_names = @districts.keys
    district_names.each do |name|
      matching << @districts[name] if name.include? name_fragment.upcase
    end
    matching
  end

end

# if $PROGRAM_NAME == __FILE__
#   data_dir = File.expand_path '../data', __dir__
#   dr = DistrictRepository.from_csv(data_dir)
#   district = dr.find_by_name("Shannon").district_name
# end
