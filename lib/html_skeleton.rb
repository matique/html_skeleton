# frozen_string_literal: true

require "date"
require "html_skeleton_calendar"
require "html_skeleton_table"

class HtmlSkeleton
  attr_reader :options

  def calendar(options = {}, &block)
    set_calendar_options(options, &block)
    month = @options[:month]
    frame = month ? "div" : "table"
    body = month ? a_month(@options[:year], month) : a_year(@options[:year])
    %(<#{frame} class="#{@options[:calendar_class]}"> #{body} </#{frame}>)
  end

  def table(rows, cols, options = {}, &block)
    set_table_options(options, &block)
    <<~TABLE
      <table class="#{@options[:table_class]}">
        #{table_header(cols)}
        #{table_body(rows, cols)}
      </table>
    TABLE
  end

  protected

  def set_calendar_options(options, &block)
    year = DateTime.now.year
    @options = {
      year: year,
      title: year,
      rows: 3,
      calendar_class: "skeleton",
      month_names: Date::MONTHNAMES,
      abbrev: (0..1),
      cell_proc: block || ->(d) { d.day.to_s },
      first_day_of_week: 1
    }.merge options

    names = options[:day_names] || Date::DAYNAMES.dup
    @options[:first_day_of_week].times { names.push(names.shift) }

    @day_header = names.collect { |day|
      abbr = day[@options[:abbrev]]
      str = (abbr == day) ? day : %(<abbr title="#{day}">#{abbr}</abbr>)
      %(<th scope="col">#{str}</th>)
    }.join
  end

  def set_table_options(options, &block)
    @options = {
      legend: nil,
      col_legend: ->(x) { x.to_s },
      row_legend: ->(x) { x.id },
      th_attribute: ->(_col) {},
      tr_attribute: ->(_row) {},

      table_class: "skeleton",
      cell_proc: block || ->(row, col) { "<td>#{row} #{col}</td>" }
    }.merge options
  end
end
