require "csv"                # => true
require_relative "district"  # ~> LoadError: cannot load such file -- enrollment

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.load_from_csv(data_dir)
    data = CSV.read(data_dir, headers: true, header_converters: :symbol).map { |row| row.to_h }
    DistrictRepository.new(data)
  end

  def find_by_name(district_name)
    district_exists = data.any? do |hash|
      hash[:location] == district_name
    end
    District.new(district_name) if district_exists
  end

  # def find_all_matching
  #
  # end

end

if $PROGRAM_NAME == __FILE__
filename = File.join data_dir, "filename.csv"
csv_data = File.read("filename")
parse_data(csv_data)

dr = DistrictRepository.new
dr.load_from_csv('./data')
district = dr.find_by_name("ACADEMY 20")
end

# ~> LoadError
# ~> cannot load such file -- enrollment
# ~>
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/shannonpaige/code/headcount/lib/district.rb:1:in `<top (required)>'
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:2:in `require_relative'
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:2:in `<main>'
