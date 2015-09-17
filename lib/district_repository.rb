require "csv"                # => true
require_relative "district"  # => true
# require "pry"

class DistrictRepository
  attr_accessor :data     # => nil

  def initialize(data)
    @data = data
  end                   # => :initialize

  def self.load_from_csv(data_dir)
    data = CSV.read(data_dir, headers: true, header_converters: :symbol).map { |row| row.to_h }  # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - ../data/Pupil enrollment.csv
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end

      data_array = grouped.map do |key, hashes|
        enrollment_data = hashes.map do |hash|
            mapped_data = hashes.map do |hash|
              [hash[:timeframe], hash[:data]]
            end
            [:enrollment, mapped_data.to_h] if data_dir == './data/Pupil enrollment.csv'
            [:pupil_enrollment, mapped_data.to_h] if data_dir == './data/Online pupil enrollment.csv'
        end
        [key, enrollment_data.to_h]
      end
      data_hash = data_array.to_h
    end
    if data_dir == './data/'
    DistrictRepository.new(data_hash)
  end                                                                                            # => :load_from_csv

  def find_by_name(district_name)
    district_exists = data.any? do |hash|
      hash.each do |key, value|
        key == district_name
      end
    end
    District.new(district_name, data.fetch(district_name)) if district_exists
  end                                                     # => :find_by_name

  def find_all_matching

  end  # => :find_all_matching

end  # => :find_all_matching

if $PROGRAM_NAME == __FILE__                                             # => true
  dr = DistrictRepository.load_from_csv('../data/Pupil enrollment.csv')
  district = dr.find_by_name("ACADEMY 20")
end

# ~> Errno::ENOENT
# ~> No such file or directory @ rb_sysopen - ../data/Pupil enrollment.csv
# ~>
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1256:in `initialize'
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1256:in `open'
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1256:in `open'
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1330:in `read'
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:13:in `load_from_csv'
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:42:in `<main>'
