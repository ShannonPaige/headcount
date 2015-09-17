
require 'csv'  # => true

#data = CSV.parse(data, headers: true, header_converters: :symbol).map { |row| row.to_h}  # ~> NoMethodError: undefined method `close' for {}:Hash

#data = CSV.read('fixture_3rd_grade.csv')
data = CSV.read('./data/Pupil enrollment.csv', headers: true, header_converters: :symbol).map { |row| row.to_h}  # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - ./data/Pupil enrollment.csv

data.group_by { |data| data[:timeframe]
  puts "#{data[:timeframe]}"
}
# data.sort_by { |data| data[:Location] }.each do |data|
#   puts "#{data[:Location]}"
# end

# CSV.foreach("./fixture_3rd_grade.csv") do |column|  # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - ./fixture_3rd_grade.csv
#
#   while i < 5 do
#     headers << column
#     i += 1
#   end
#
# end
#
# puts headers

# ~> Errno::ENOENT
# ~> No such file or directory @ rb_sysopen - ./data/Pupil enrollment.csv
# ~>
# ~> /Users/charissalawrence/.rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1256:in `initialize'
# ~> /Users/charissalawrence/.rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1256:in `open'
# ~> /Users/charissalawrence/.rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1256:in `open'
# ~> /Users/charissalawrence/.rubies/ruby-2.2.2/lib/ruby/2.2.0/csv.rb:1330:in `read'
# ~> /Users/charissalawrence/Documents/Turing/Module1/headcount/rudimentary_test2.rb:7:in `<main>'
