require "district_repository"

class HeadcountAnalyst
  attr_accessor :dr

  def initialize(dr)
    @dr = dr
  end

  def truncate_float(value)
    if value < 0
      value = value.to_s[0..5].to_f
    else
      value = value.to_s[0..4].to_f
    end
    value
  end

  def average(array)
    array.reduce(0){ |sum, el| sum + el }.to_f / array.size
  end

  def top_statewide_testing_year_over_year_growth(top = {:top => 1}, subject = {}, weighting = {})
    #something like....
    # loop through every district
    # call .proficient_for_subject_in_year(subject, year) for min and max years
    # - if subject = {} will have to loop thru all subjects (do in another method?)
    # - if weights != {} will have to weight the subjects (do in another method?)
    # subtract and divide by two
    # add the districts scores to a hash (or array idk)
    # somehow sort them so we know which ones have the highest scores

    #if :top =>1 just return the score
    #if :top is > 1 return an array of all the top districts with their scores
    if top[:top] == 1
      #return the score of the highest one
    else
      #return array of all the top[:top] districts (most likely 3) with their scores
      # (this allows for more sizes - top 2, top 4, etc....)
    end
  end

  def kindergarten_participation_rate_variation(district_name, against)
    district_part_rates = @dr.find_by_name(district_name).enrollment.kindergarten_participation_by_year.values
    district_average = average(district_part_rates)
    against_name = against[:against]
    against_name = 'COLORADO' if against[:against] == 'state'
    against_rates = @dr.find_by_name(against_name).enrollment.kindergarten_participation_by_year.values
    against_average = average(against_rates)
    average = district_average/against_average
    Parse.truncate_float(average)
  end

  def kindergarten_participation_against_household_income(district_name)
    income_variation = median_income_variation(district_name)
    kindergarten_variation = kindergarten_participation_rate_variation(district_name, :against => 'state')
    corelation = kindergarten_variation/income_variation
    truncate_float(corelation)
  end

  def median_income_variation(district_name)
    median_income_values = @dr.find_by_name(district_name).economicprofile.median_income.values
    median_income_average = average(median_income_values)
    state_income_values = @dr.find_by_name('COLORADO').economicprofile.median_income.values
    state_income_average = average(state_income_values)
    average = median_income_average/state_income_average
    Parse.truncate_float(average)
  end

  def kindergarten_participation_correlates_with_household_income(consider)
    for_or_across = consider.keys
    district_name = consider[for_or_across[0]]
    if district_name == 'state'
      considered_districts = @dr.districts.keys
      return true if check_kinder_coorelation(considered_districts)
    elsif district_name.class == Array
      considered_districts = consider[for_or_across[0]]
      return true if check_kinder_coorelation(considered_districts)
    else
      considered_districts = [district_name]
      return true if check_kinder_coorelation(considered_districts)
    end
    false
  end

  def check_kinder_coorelation(considered_districts)
    tolerance = considered_districts.length * 0.70
    correlation_list = []
    considered_districts.each do |district_name|
      kp = kindergarten_participation_against_household_income(district_name)
      if kp < 1.5 && kp > 0.6
        correlation_list << district_name
      end
    end
    return true if correlation_list.length > tolerance
  end

  def kindergarten_participation_against_high_school_graduation(district_name)
    # Call kindergarten variation the result of dividing the district's
    #kindergarten participation by the statewide average. Call graduation
    #variation the result of dividing the district's graduation rate by the
    #statewide average. Divide the kindergarten variation by the graduation
    #variation to find the kindergarten-graduation variance.
    #
    # If this result is close to 1, then we'd infer that the kindergarten
    #variation and the graduation variation are closely related.
  end

  def kindergarten_participation_correlates_with_high_school_graduation(foor = {})
    # Let's consider the kindergarten_participation_against_high_school_graduation
    #and set a correlation window between 0.6 and 1.5. If the result is in that
    #range then we'll say that they are correlated.
  end
end
