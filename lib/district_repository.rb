require "csv"
require_relative "district"
# require "pry"

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.load_from_csv(data_dir)
    data_hash = {}

    # reads in the Pupil enrollment file
    data = CSV.read(File.join(data_dir, 'Pupil enrollment.csv'), headers: true, header_converters: :symbol).map { |row| row.to_h }
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      data_hash[district_name][:pupil_enrollment] = mapped_data.to_h
    end

    #reads in the online pupil enrollment file
    data = CSV.read(File.join(data_dir, 'Online pupil enrollment.csv'), headers: true, header_converters: :symbol).map { |row| row.to_h }
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      data_hash[district_name][:online_pupil_enrollment] = mapped_data.to_h
    end

    #reads in online pupil enrollment by race
    data = CSV.read(File.join(data_dir, 'Pupil enrollment by race_ethnicity.csv'), headers: true, header_converters: :symbol).map { |row| row.to_h }
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe], hash[:data]]
      end
      mapped_data = mapped_data.to_h
      raced_map = hashes.map do |hash|
        [hash[:race], mapped_data]
      end
      raced_map.to_h
    data_hash[district_name][:pupil_enrollment_by_race] = raced_map.to_h
    end

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
