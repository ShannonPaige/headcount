
module Parse
  def self.read_in_file(data_dir, file)
    CSV.read(File.join(data_dir, file), headers: true, header_converters: :symbol)
        .map { |row| row.to_h }
  end

  def self.truncate_float(float)
    ((float.to_f * 1000).to_i)/1000.to_f
  end

  def self.number_or_percent(hash)
    if hash[:dataformat] == "Percent"
      [hash[:timeframe].to_i, truncate_float(hash[:data].to_f)]
    else
      [hash[:timeframe].to_i, hash[:data].to_i]
    end
  end

  def self.map_year_to_data(hashes)
    mapped_data = hashes.map do |hash|
      number_or_percent(hash)
    end
  end

  def self.filename_to_symbol(file)
    file.gsub('.csv', "")
        .gsub('3', "three")
        .gsub('4', "four")
        .gsub('8', "eight")
        .gsub(" ", '_')
        .gsub("-", '_')
        .downcase.to_sym
  end

  def self.group_by_district(data)
    grouped = data.group_by do |hash|
      hash.fetch(:location).upcase
    end
  end

  def self.group_by_info(info, hashes)
    grouped_by_info = hashes.group_by do |hash|
      hash.fetch(info)
    end
  end

  def self.find_header_info_type(data)
    info = ""
    data.each do |hash|
      info = hash.keys[1]
    end
    info
  end

  def self.year_data(data_dir, data_hash, file)
    data = read_in_file(data_dir, file)
    group_by_district(data).each do |district_name, hashes|
      data_hash[district_name] ||= {}
      mapped_data = map_year_to_data(hashes)
      data_hash[district_name][filename_to_symbol(file)] = mapped_data.to_h
    end
  end

  def self.info_year_data(data_dir, data_hash, file)
    data = read_in_file(data_dir, file)
    info = find_header_info_type(data)
    group_by_district(data).each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename_to_symbol(file)] ||= {}
      group_by_info(info, hashes).each do |info_type, hashes|
        data_hash[district_name] ||= {}
        mapped_data = map_year_to_data(hashes)
        data_hash[district_name][filename_to_symbol(file)][info_type] = mapped_data.to_h
      end
    end
  end

  def self.info_year_datatype_data(data_dir, data_hash, file)
    data = read_in_file(data_dir, file)
    info = find_header_info_type(data)
    group_by_district(data).each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename_to_symbol(file)] ||= {}
      group_by_info(info, hashes).each do |info_type, hashes|
        data_hash[district_name][filename_to_symbol(file)][info_type] ||= {}
        percents = hashes.select { |hash| hash[:dataformat].include?("Percent")}
        numbers = hashes.select { |hash| hash[:dataformat].include?("Number")}
        percents.each do |hash|
          data_hash[district_name] ||= {}
          mapped_data = map_year_to_data(percents)
          data_hash[district_name][filename_to_symbol(file)][info_type][:percent] = mapped_data.to_h
        end
        numbers.each do |hash|
          data_hash[district_name] ||= {}
          mapped_data = map_year_to_data(numbers)
          data_hash[district_name][filename_to_symbol(file)][info_type][:numbers] = mapped_data.to_h
        end
      end
    end
  end

  def self.info_year_dataformat_data(data_dir, data_hash, file)
    data = read_in_file(data_dir, file)
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
      mapped_data = map_year_to_data(hashes)
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
      mapped_data = map_year_to_data(hashes)
      data_hash[district_name][filename] = mapped_data.to_h
    end
    data_hash
  end

  def self.info_poverty_year_dataformat(data_dir, data_hash, file)
    data = read_in_file(data_dir, file)
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
      mapped_data = map_year_to_data(hashes)
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
      mapped_data = map_year_to_data(hashes)
      mapped_data = mapped_data.to_h
      info_map = hashes.map do |hash|
        [hash[:poverty_level], mapped_data]
      end
    data_hash[district_name][filename] = info_map.to_h
    end
  end

  def self.info_subject_year_data(data_dir, data_hash, file)
    filename = file.gsub('.csv', "").gsub('3', "three").gsub('8', "eight").gsub(" ", '_').gsub("-", '_').downcase.to_sym
    data = read_in_file(data_dir, file)
    info = ""
    flag = false
    data.each do |hash|
      info = hash.keys[2]
    end
    grouped_by_district = data.group_by do |hash|
      hash.fetch(:location).upcase
    end
    grouped_by_district.each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename] = {}
      info_map = []
      grouped_by_info = hashes.group_by do |hash|
        hash.fetch(info).to_i
      end
      grouped_by_info.each do |info_type, hashes|
        data_hash[district_name][filename][info_type] ||= {}
        mapped_data = hashes.map do |hash|
          if hash[:dataformat] == "Number"
            [hash[:score].downcase.to_sym, hash[:data].to_i]
          else
            if hash[:data] == "N/A" || hash[:data] == "#VALUE!" || hash[:data] == "LNE"
              flag = true
            end
            [hash[:score].downcase.to_sym, truncate_float(hash[:data].to_f)]
          end
        end
        if flag
          data_hash[district_name] = {}
          data_hash[district_name][filename] = {}
          data_hash[district_name][filename][info_type] = {}
        else
          data_hash[district_name][filename][info_type] = mapped_data.to_h
        end
      end
    end
  end

  def self.info_race_year_data(data_dir, data_hash, file)
    data = read_in_file(data_dir, file)
    info = ""
    data.each do |hash|
      info = hash.keys[2]
    end
    group_by_district(data).each do |district_name, hashes|
      data_hash[district_name] ||= {}
      data_hash[district_name][filename_to_symbol(file)] ||= {}
      info_map = []
      grouped_by_info = hashes.group_by do |hash|
        hash.fetch(info).to_i
      end
      grouped_by_info.each do |info_type, hashes|
        data_hash[district_name][filename_to_symbol(file)][info_type] ||= {}
        mapped_data = hashes.map do |hash|
          if hash[:dataformat] == "Number"
            [hash[:race_ethnicity].to_s, hash[:data].to_i]
          else
            [hash[:race_ethnicity].to_s, truncate_float(hash[:data].to_f)]
          end
        end
        data_hash[district_name][filename_to_symbol(file)][info_type] = mapped_data.to_h
      end
    end
  end
end
