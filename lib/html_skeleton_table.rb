# frozen_string_literal: true

require "date"

# table methods ######################################################
class HtmlSkeleton
  protected

  def table_header(cols)
    legend = @options[:legend]
    th_attribute = @options[:th_attribute]
    return "" unless legend

    proc = @options[:col_legend]
    col_header = cols.collect { |col|
      "<th #{th_attribute.call(col)}>#{proc.call(col)}</th>"
    }.join
    %(<thead><th class="legend">#{legend}</th>#{col_header}</thead>)
  end

  def table_body(rows, cols)
    legend = @options[:legend]
    row_legend = @options[:row_legend]
    tr_attribute = @options[:tr_attribute]
    rows.collect { |row|
      rlegend = ""
      rlegend = %(<td class="legend">#{row_legend.call(row)}</td>) if legend
      cells = table_row(row, cols)
      %(<tr #{tr_attribute.call(row)}>#{rlegend}#{cells}</tr>)
    }.join("\n")
  end

  def table_row(row, cols)
    cell_proc = @options[:cell_proc]
    cols.collect { |col| cell_proc.call(row, col) }.join
  end
end
