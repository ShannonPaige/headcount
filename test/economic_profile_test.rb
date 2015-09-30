require 'minitest/autorun'
require 'minitest/pride'
require "economic_profile"
require "district_repository"

class EconomicProfileTest < Minitest::Test

  def setup
    @dr = DistrictRepositoryTest.make_repository
    @district = @dr.find_by_name("ACADEMY 20")
    @economic_profile_instance = @district.economic_profile
  end

  def test_free_or_reduced_lunch_in_year
    #not truncating without rounding or sorting low to high
    expected = { 2000 => 0.020,
    2001 => 0.024,
    2002 => 0.027,
    2003 => 0.030,
    2004 => 0.034,
    2005 => 0.058,
    2006 => 0.041,
    2007 => 0.050,
    2008 => 0.061,
    2009 => 0.070,
    2010 => 0.079,
    2011 => 0.084,
    2012 => 0.125,
    2013 => 0.091,
    2014 => 0.087,}
    assert_equal expected, @economic_profile_instance.free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year
    assert_equal 0.125, @economic_profile_instance.free_or_reduced_lunch_in_year(2012)
  end

  def test_school_aged_children_in_poverty_by_year
    expected = { 1995 => 0.032,
      1997 => 0.035,
      1999 => 0.032,
      2000 => 0.031,
      2001 => 0.029,
      2002 => 0.033,
      2003 => 0.037,
      2004 => 0.034,
      2005 => 0.042,
      2006 => 0.036,
      2007 => 0.039,
      2008 => 0.044,
      2009 => 0.047,
      2010 => 0.057,
      2011 => 0.059,
      2012 => 0.064,
      2013 => 0.048,
    }
    assert_equal expected, @economic_profile_instance.school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year
    assert_equal 0.064, @economic_profile_instance.school_aged_children_in_poverty_in_year(2012)
  end

  def test_title_1_students_by_year
    #not truncating properly
    expected = {2009 => 0.014, 2011 => 0.011, 2012 => 0.01, 2013 => 0.012, 2014 => 0.027}
    assert_equal expected, @economic_profile_instance.title_1_students_by_year
  end

  def test_title_1_students_in_year
    assert_equal 0.01, @economic_profile_instance.title_1_students_in_year(2012)
  end

end
