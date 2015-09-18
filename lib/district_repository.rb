require "csv"
require_relative "district"
# require "pry"

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.parse_data_type_1(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      data_hash[district_name][filename] = mapped_data.to_h
    end
  end

  def self.parse_data_type_2(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    info = ""
    data.each do |hash|
      info = hash.keys[1]
    end
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      mapped_data = mapped_data.to_h
      info_map = hashes.map do |hash|
        [hash[info], mapped_data]
      end
    data_hash[district_name][filename] = info_map.to_h
    end
  end

  def self.load_from_csv(data_dir)
    data_hash = {}
    parse_data_type_1(data_dir, data_hash, 'Pupil enrollment.csv')
    parse_data_type_1(data_dir, data_hash, 'Online pupil enrollment.csv')
    parse_data_type_1(data_dir, data_hash, 'High school graduation rates.csv')
    parse_data_type_1(data_dir, data_hash, 'Kindergartners in full-day program.csv')
    parse_data_type_1(data_dir, data_hash, 'Median household income.csv')
    parse_data_type_1(data_dir, data_hash, 'Remediation in higher education.csv')
    parse_data_type_1(data_dir, data_hash, 'Title I students.csv')
    parse_data_type_2(data_dir, data_hash, '3rd grade students scoring proficient or above on the CSAP_TCAP.csv')
    parse_data_type_2(data_dir, data_hash, '8th grade students scoring proficient or above on the CSAP_TCAP.csv')
    parse_data_type_2(data_dir, data_hash, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv')
    parse_data_type_2(data_dir, data_hash, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv')
    parse_data_type_2(data_dir, data_hash, 'Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv')
    parse_data_type_2(data_dir, data_hash, 'Dropout rates by race and ethnicity.csv')

    DistrictRepository.new(data_hash)
  end



  def find_by_name(district_name)
    district_names = data.keys # => ["Colorado", "ACADEMY 20", "ADAMS COUNTY 14", "ADAMS-ARAPAHOE 28J", "AGATE 300", "AGUILAR REORGANIZED 6", "AKRON R-1", "ALAMOSA RE-11J", "ARCHULETA COUNTY 50 JT", "ARICKAREE R-2", "ARRIBA-FLAGLER C-20", "ASPEN 1", "AULT-HIGHLAND RE-9", "BAYFIELD 10 JT-R", "BENNETT 29J", "BETHUNE R-5", "BIG SANDY 100J", "BOULDER VALLEY RE 2", "BRANSON REORGANIZED 82", "BRIGGSDALE RE-10", "BRIGHTON 27J", "BRUSH RE-2(J)", "BUENA VISTA R-31", "BUFFALO RE-4", "BURLINGTON RE-6J", "BYERS 32J", "CALHAN RJ-1", "CAMPO RE-6", "CANON CITY RE-1", "CENTENNIAL R-1", "CENTER 26 JT", "CHERAW 31", "CHERRY CREEK 5", "CHEYENNE COUNTY RE-5", "CHEYENNE MOUNTAIN 12", "CLEAR CREEK RE-1", "COLORADO SPRINGS 11", "COTOPAXI RE-3", "CREEDE CONSOLIDATED 1", "CRIPPLE CREEK-VICTOR RE-1", "CROWLEY COUNTY RE-1-J", "CUSTER COUNTY SCHOOL DISTRICT C-1", "DE BEQUE 49JT", "DEER TRAIL 26J", "DEL NORTE C-7", "DELTA COUNTY 50(J)", "DENVER COUNTY 1", "DOLORES COUNTY RE NO.2", "DOLORES RE-4A", "DOUGLAS COUN...
    district_exists = district_names.any? do |name|
      name == district_name
    end
    District.new(district_name, data.fetch(district_name)) if district_exists
  end

  def find_all_matching

  end

end

if $PROGRAM_NAME == __FILE__
  data_dir = File.expand_path '../data', __dir__
  dr = DistrictRepository.load_from_csv(data_dir)
  district = dr.find_by_name("Shannon").district_name # ~> NoMethodError: undefined method `district_name' for nil:NilClass
  # =>
end

# ~> NoMethodError
# ~> undefined method `district_name' for nil:NilClass
# ~>
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:89:in `<main>'
