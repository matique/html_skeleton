require 'date'

# calendar methods ###################################################
class HtmlSkeleton
  attr_reader :day_header

 protected
  def a_year(year)
    rows = @options[:rows]
    cols = 12 / rows
    raise 'html_skeleton_calendar: invalid option <rows>' unless rows * cols == 12

    body = (0..rows - 1).collect { |y|
      str = (1..cols).collect { |x| "<td>#{a_month(year, y * cols + x)}</td>" }
      "<tr>#{str.join('')}</tr>"
    }
    <<~THEAD
      <thead><th colspan="2">#{@options[:title]}</th></thead>
      #{body.join('')}
    THEAD
  end

  def a_month(year, month)
    title = @options[:month_names][month]
    <<~TABLE
      <table class="month">
        <tr class="monthName"><th colspan="7">#{title}</th></tr>
        <tr class="dayName">#{@day_header}</tr>
        #{days_of_month(year, month)}
      </table>
    TABLE
  end

  def days_of_month(year, month)
    first_weekday = @options[:first_day_of_week]
    last_weekday  = first_weekday.positive? ? first_weekday - 1 : 6
    cell_proc = @options[:cell_proc]
    bool = Time.respond_to?(:zone) && !(zone = Time.zone).nil?
    today = bool ? zone.now.to_date : Date.today

    first = Date.civil(year, month, 1)
    last  = Date.civil(year, month, -1)

    cal = '<tr>'
    cal << '<td></td>' * days_between(first_weekday, first.wday)
    first.upto(last) { |cur|
      cal << a_day(cur, today, cell_proc)
      cal << '</tr> <tr>' if cur.wday == last_weekday
    }
    cal << '<td></td>' * days_between((last + 1).wday, first_weekday + 7)
    cal << '</tr>'
  end

  def a_day(date, today, block)
    attrs = 'day'
    attrs += ' weekendDay'  if weekend?(date)
    attrs += ' today'       if date == today
    "<td class=\"#{attrs}\">#{block.call(date)}</td>"
#    "<td class=\"#{attrs}\">##</td>"
  end

  def weekend?(date)
    [0, 6].include?(date.wday)
  end

  def days_between(first, second)
    first > second ? second + (7 - first) : second - first
  end
end
