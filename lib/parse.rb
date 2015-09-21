
module Parse

  def self.truncate_float(float)
    ((float.to_f * 1000).to_i)/1000.to_f
  end

  def self.number_or_percent(hash)
    if hash[:dataformat] == "Number"
      [hash[:timeframe].to_i, hash[:data].to_i]
    else
      [hash[:timeframe].to_i, truncate_float(hash[:data].to_f)]
    end
  end

  def self.parse_data_type_1(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    grouped = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        number_or_percent(hash)
      end
      data_hash[district_name][filename] = mapped_data.to_h
    end
  end

  def self.parse_data_type_2(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    info = ""
    data.each do |hash|
      info = hash.keys[1]
    end
    grouped_by_district = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped_by_district.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename] ||= {}
      info_map = []
      grouped_by_info = hashes.group_by do |hash|
        hash.fetch(info)
      end
      grouped_by_info.each do |info_type, hashes|
        data_hash[district_name][filename][info_type] ||= {}
        mapped_data = hashes.map do |hash|
          number_or_percent(hash)
        end
        data_hash[district_name][filename][info_type] = mapped_data.to_h
      end
    end
  end

  def self.parse_data_type_3(data_dir, data_hash, file)
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }

    #create hash with whole number values
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase
    numbers = data.select { |hash| hash[:dataformat].include?("Number")}
    filename << "_by_number"
    filename = filename.to_sym
    numbers = numbers.group_by do |hash|
        hash.fetch(:location)
    end

    numbers.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      data_hash[district_name][filename] = mapped_data.to_h
    end

    #create hash with percent values
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase
    percent = data.select { |hash| hash[:dataformat].include?("Percent")}
    filename << "_by_percentage"
    filename = filename.to_sym
    percent = percent.group_by do |hash|
        hash.fetch(:location)
    end

    percent.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, truncate_float(hash[:data].to_f)]
      end
      data_hash[district_name][filename] = mapped_data.to_h
    end
    data_hash
  end

  def self.parse_data_type_4(data_dir, data_hash, file)
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    #create hash with whole number values
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase
    numbers = data.select { |hash| hash[:dataformat].include?("Number")}
    filename << "_by_number"
    filename = filename.to_sym
    numbers = numbers.group_by do |hash|
        hash.fetch(:race)
    end

    numbers.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      data_hash[district_name][filename] = mapped_data.to_h
    end

    #create hash with percent values
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase
    percent = data.select { |hash| hash[:dataformat].include?("Percent")}
    filename << "_by_percentage"
    filename = filename.to_sym
    percent = percent.group_by do |hash|
        hash.fetch(:race)
    end

    percent.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_f]
      end
      data_hash[district_name][filename] = mapped_data.to_h
    end
  end

  def self.parse_data_type_5(data_dir, data_hash, file)
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    #create hash with whole number values
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase
    group_by_numbers = data.select { |hash| hash[:dataformat].include?("Number")}
    filename << "_by_number"
    filename = filename.to_sym
    group_by_numbers = group_by_numbers.group_by do |hash|
        hash.fetch(:location)
    end
    group_by_numbers.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, hash[:data].to_i]
      end
      mapped_data = mapped_data.to_h
      info_map = hashes.map do |hash|
        [hash[:poverty_level], mapped_data]
      end
    data_hash[district_name][filename] = info_map.to_h
    end

    #create hash with percentage values
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase
    group_by_percent = data.select { |hash| hash[:dataformat].include?("Percent")}
    filename << "_by_percentage"
    filename = filename.to_sym
    group_by_percent = group_by_percent.group_by do |hash|
        hash.fetch(:location)
    end
    group_by_percent.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = hashes.map do |hash|
        [hash[:timeframe].to_i, truncate_float(hash[:data].to_f)]
      end
      mapped_data = mapped_data.to_h
      info_map = hashes.map do |hash|
        [hash[:poverty_level], mapped_data]
      end
    data_hash[district_name][filename] = info_map.to_h
    end
  end

  def self.parse_data_type_6(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    info = ""
    data.each do |hash|
      info = hash.keys[2]
    end
    info
    grouped_by_district = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped_by_district.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename] ||= {}
      info_map = []
      grouped_by_info = hashes.group_by do |hash|
        hash.fetch(info).to_i
      end
      grouped_by_info
      grouped_by_info.each do |info_type, hashes|
        data_hash[district_name][filename][info_type] ||= {}
        mapped_data = hashes.map do |hash|
          if hash[:dataformat] == "Number"
            [hash[:score].downcase.to_sym, hash[:data].to_i]
          else
            [hash[:score].downcase.to_sym, truncate_float(hash[:data].to_f)]
          end
        end
        data_hash[district_name][filename][info_type] = mapped_data.to_h
      end
    end
  end

  def self.parse_data_type_7(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol).map { |row| row.to_h }
    info = ""
    data.each do |hash|
      info = hash.keys[2]
    end
    info
    grouped_by_district = data.group_by do |hash|
      hash.fetch(:location)
    end
    grouped_by_district.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename] ||= {}
      info_map = []
      grouped_by_info = hashes.group_by do |hash|
        hash.fetch(info).to_sym
      end
      grouped_by_info
      grouped_by_info.each do |info_type, hashes|
        data_hash[district_name][filename][info_type] ||= {}
        mapped_data = hashes.map do |hash|
          if hash[:dataformat] == "Number"
            [hash[:race_ethnicity].downcase.to_s, hash[:data].to_i]
          else
            [hash[:race_ethnicity].downcase.to_s, truncate_float(hash[:data].to_f)]
          end
        end
        data_hash[district_name][filename][info_type] = mapped_data.to_h
      end
    end
  end
end