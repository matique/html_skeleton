require "test_helper"
require File.expand_path(File.dirname(__FILE__) + "../../lib/html_skeleton")

class HtmlSkeletonCalendarTest < ActiveSupport::TestCase
  def test_html_calendar
    cal = a_calendar
    assert_not_nil cal
    assert_tag_count(cal, "tr", 92)
    assert_tag_count(cal, "table", 13)
    assert_css_class(cal, "table", "skeleton")
    assert_match %r{August}, cal
  end

  def test_month_calendar
    cal = a_month_calendar
    assert_not_nil cal
    assert_tag_count(cal, "div", 1)
    assert_tag_count(cal, "table", 1)
    assert_tag_count(cal, "tr", 7)
    assert_css_class(cal, "div", "skeleton")
    assert_css_class(cal, "table", "month")
  end

  def test_custom_css_class
    klass = "custom"
    cal = a_calendar(calendar_class: klass)
    assert_css_class(cal, "table", klass)
  end

  def test_abbrev
    cal = a_calendar
    assert_match %r{>Mo<}, cal
    refute_match %r{>Monday<}, cal
    assert_match %r{>Monday<}, a_calendar(abbrev: 0..5)
  end

  def test_cell_block
    cal = HtmlSkeleton.new.calendar(year: 2012) { |d|
      d.day == 15 ? "<bingo></bingo>" : d.day.to_s
    }
    assert_tag_count(cal, "bingo", 12)
  end

  def test_today_is_in_calendar
    todays_day = Time.now.day
    assert_match %r{class="day .*today"[^>]*>#{todays_day}<}, this_month_calendar
  end

  def test_first_day_of_week
    assert_match %r{<tr class="dayName">\s*<th [^>]*scope="col"><abbr title="Monday">Mo}, a_calendar
    assert_match %r{<tr class="dayName">\s*<th [^>]*scope="col"><abbr title="Sunday">Su}, a_calendar(first_day_of_week: 0)
  end

  private

  def a_calendar(options = {})
    HtmlSkeleton.new.calendar({year: 2012}.merge(options))
  end

  def a_month_calendar(options = {})
    HtmlSkeleton.new.calendar({year: 2012, month: 8}.merge(options))
  end

  def this_month_calendar(options = {})
    now = Time.now
    HtmlSkeleton.new.calendar({year: now.year, month: now.month}.merge(options))
  end
end
