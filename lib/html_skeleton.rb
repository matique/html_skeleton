require 'date'
require 'html_skeleton_calendar'
require 'html_skeleton_table'

class HtmlSkeleton
  attr_reader :options

  def calendar(options = {}, &block)
    set_calendar_options(options, &block)
    frame = @options[:month] ? 'div' : 'table'
    body  = @options[:month] ?
		a_month(@options[:year], @options[:month]) :
		a_year(@options[:year])
    %Q{<#{frame} class="#{@options[:calendar_class]}"> #{body} </#{frame}>}
  end

  def table(rows, cols, options = {}, &block)
    set_table_options(options, &block)
    <<-EOS
<table class="#{@options[:table_class]}">
  #{table_header(cols)}
  #{table_body(rows, cols)}
</table>
    EOS
  end


 protected
  def set_calendar_options(options, &block)
    year = DateTime.now.year
    @options = {
      :year        => year,
      :title       => year,
      :calendar_class => 'skeleton',
      :month_names => Date::MONTHNAMES,
      :abbrev      => (0..1),
      :cell_proc   => block || lambda {|d| d.day.to_s},
      :first_day_of_week => 1
    }.merge options

    names = options[:day_names] || Date::DAYNAMES.dup
    @options[:first_day_of_week].times { names.push(names.shift) }

    @day_header = names.collect { |day|
      abbr = day[@options[:abbrev]]
      str = abbr == day ? day : %Q{<abbr title='#{day}'>#{abbr}</abbr>}
      %Q{<th scope='col'>#{str}</th>}
    }.join('')
  end

  def set_table_options(options, &block)
    @options = {
      :legend => nil,
      :col_legend => lambda(&:to_s),
      :row_legend => lambda(&:id),
      :th_attribute => lambda { |col| nil },
      :tr_attribute => lambda { |row| nil },

      :table_class => 'skeleton',
      :cell_proc   => block || lambda {|row, col| "<td>#{row} #{col}</td>"},
    }.merge options
  end

end
