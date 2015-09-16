
require 'minitest/autorun'
require 'minitest/pride'
require "district_repository"

class DistrictRepositoryTest < Minitest::Test

  # def data_dir
  #   File.expand_path '../data', __dir__
  # end
  meta(current: true)
  def test_it_can_load_a_district_from_csv_data
    dr = DistrictRepository.load_from_csv('./data/Pupil enrollment.csv')
    district = dr.find_by_name("ACADEMY 20")
    assert_equal "ACADEMY 20", dr.find_by_name("ACADEMY 20").district_name
    assert_equal "22620", district.enrollment.in_year(2009)
    # assert_equal 0.895, district.enrollment.graduation_rate.for_high_school_in_year(2010)
    # assert_equal 0.857, district.statewide_testing.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
  end

  def test_returns_nil_if_district_doesnt_exist
    dr = DistrictRepository.load_from_csv('./data/Pupil enrollment.csv')
    assert_nil dr.find_by_name("Shannon")
  end

  def test_returns_district_name_after_case_insensitive_search
    skip
  end

  def test_returns_empty_array_if_no_districts_match_supplied_name_fragment
    skip
  end

  def test_returns_all_districts_which_match_supplied_name_fragment
    skip
  end


end
