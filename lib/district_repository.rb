require "csv"
require "district"

class DistrictRepository
  attr_accessor :data

  def self.load_from_csv(data_dir)
    @data = CSV.read(data_dir, headers: true, header_converters: :symbol).map { |row| row.to_h }
    DistrictRepository.new
  end

  def find_by_name(name)
    District.new(name)
  end

  def find_all_matching

  end

end

if $PROGRAM_NAME == __FILE__
filename = File.join data_dir, "filename.csv"
csv_data = File.read("filename")
parse_data(csv_data)

dr = DistrictRepository.new
dr.load_from_csv('./data')
district = dr.find_by_name("ACADEMY 20")
end
