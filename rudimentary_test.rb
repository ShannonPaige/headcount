
handle = File.open("fixture_3rd_grade.csv")  # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - fixture_3rd_grade

location = []
number = []
handle.each_line do |line|
  parsed_data = line.split(",")
  location << parsed_data[0]
  number << parsed_data[1].chomp
end
puts "#{location} \n #{number}"
number

# ~> Errno::ENOENT
# ~> No such file or directory @ rb_sysopen - fixture_3rd_grade
# ~>
# ~> /Users/charissalawrence/Documents/Turing/Module1/headcount/test.rb:2:in `initialize'
# ~> /Users/charissalawrence/Documents/Turing/Module1/headcount/test.rb:2:in `open'
# ~> /Users/charissalawrence/Documents/Turing/Module1/headcount/test.rb:2:in `<main>'
