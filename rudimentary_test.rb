
handle = File.open("./fixture_3rd_grade.csv")   # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - fixture_3rd_grade.csv
headers = []
has_headers = true
third_grade = []
handle.each_line do |line|
  hash = {}
  parsed_data = line.split(",")
  parsed_data[parsed_data.length - 1].chomp!
  if has_headers
    headers = parsed_data
    has_headers = false
  else
    for x in 0...parsed_data.length
      hash[headers[x]] = parsed_data[x]
    end
    third_grade << hash
  end
end

p third_grade

# ~> Errno::ENOENT
# ~> No such file or directory @ rb_sysopen - fixture_3rd_grade.csv
# ~>
# ~> /Users/shannonpaige/code/headcount/rudimentary_test.rb:2:in `initialize'
# ~> /Users/shannonpaige/code/headcount/rudimentary_test.rb:2:in `open'
# ~> /Users/shannonpaige/code/headcount/rudimentary_test.rb:2:in `<main>'
