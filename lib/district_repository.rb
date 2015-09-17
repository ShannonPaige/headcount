require "csv"                # => true
require "../lib/district"
# require "pry" # ~> LoadError: cannot load such file -- enrollment

class DistrictRepository
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def self.load_from_csv(data_dir)
    if data_dir == '../data/Pupil enrollment.csv'
    data = CSV.read(data_dir, headers: true, header_converters: :symbol).map { |row| row.to_h }
    #do some fancy shit here

    # data.sort_by { |data| data[:timeframe]
    #   puts data
    #     #puts "#{data[:timeframe]}"
    #
    # }
    district_hash = {}
    data_hashes = {}
    last_location_instance = {} #hash[:location]

    data.sort_by { |hash| }.each do |hash|
      #require "pry"; binding.pry
      # if district_hash.include? hash[:location]
      #   district_hash[hash[:location]] = {:enrollment => {hash[:timeframe] => hash[:data]}}
      # else
      #   district_hash[hash[:location]] = {}
      #
      #   puts "#{district_hash}\n"
      # end

      if hash[:location] != last_location_instance
        #if the location in the row is new
        puts "New!!! "
        data_hashes = {hash[:timeframe] => hash[:data]}
      else
        #keep loading the new values into data_hashes
        data_hashes = {hash[:timeframe] => hash[:data]}
        district_hash = district_hash.merge!(data_hashes)
      end
      last_location_instance = hash[:location]
      puts district_hash

      #my_hash.merge!(:nested_hash => {:first_key => 'Hello' })

      # if condition
      #   #the last line of that districts data is reached, create a new hash of the array just created
      # end

      # while hash[:location] == first_location_instance
      #   data_hashes = {hash[:timeframe] => hash[:data]}
      # end

    end

    # while i < empty_spaces_on_board.length do
    #   p empty_space_symbol = empty_spaces_on_board[i]
    #   p index_mark = 'VB'+i.to_s
    #
    #   new_board_hash = {index_mark => move_as_somebody(board, player, empty_space_symbol).grid}
    #
    #   virtual_board_hash = virtual_board_hash.merge(new_board_hash)
    #
    #   i += 1
    # end
    # p virtual_board_hash
    end
    DistrictRepository.new(data)
  end

  def find_by_name(district_name)
    district_exists = data.any? do |hash|
      hash[:location] == district_name
    end
    District.new(district_name, data) if district_exists
  end

  def find_all_matching

  end

end



if $PROGRAM_NAME == __FILE__
# filename = File.join data_dir, "filename.csv"
# csv_data = File.read("filename")
# parse_data(csv_data)
#
dr = DistrictRepository.load_from_csv('../data/Pupil enrollment.csv')
#dr.load_from_csv('Pupil enrolment.csv')
# district = dr.find_by_name("ACADEMY 20")
end

# ~> LoadError
# ~> cannot load such file -- enrollment
# ~>
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/shannonpaige/.rvm/rubies/ruby-2.2.2/lib/ruby/site_ruby/2.2.0/rubygems/core_ext/kernel_require.rb:54:in `require'
# ~> /Users/shannonpaige/code/headcount/lib/district.rb:1:in `<top (required)>'
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:2:in `require_relative'
# ~> /Users/shannonpaige/code/headcount/lib/district_repository.rb:2:in `<main>'
