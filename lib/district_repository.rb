require "csv"
require_relative "district"
# require "pry"

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.parse_data_type_1(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub(" ", '_').downcase.to_sym
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
    filename = file.gsub('.csv', "").gsub(" ", '_').downcase.to_sym
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
    district_exists = data.any? do |hash|
      hash.each do |key, value|
        key == district_name
      end
    end
    District.new(district_name, data.fetch(district_name)) if district_exists
  end

  def find_all_matching

  end

end

if $PROGRAM_NAME == __FILE__
  dr = DistrictRepository.load_from_csv('../data/Pupil enrollment.csv')
  district = dr.find_by_name("ACADEMY 20")
end
