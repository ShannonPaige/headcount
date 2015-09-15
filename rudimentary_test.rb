

require "csv"
def parse_data
  CSV.parse(data, headers: true, header_converters: :symbol).map { |row| row.to_h }
end
filename = File.join data_dir, "filename.csv"
csv_data = File.read("filename")
parse_data(csv_data)
