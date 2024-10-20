# HtmlSkeleton

[![Gem Version](https://badge.fury.io/rb/html_skeleton.svg)](http://badge.fury.io/rb/html_skeleton)
[![GEM Downloads](https://img.shields.io/gem/dt/html_skeleton?color=168AFE&logo=ruby&logoColor=FE1616)](https://rubygems.org/gems/html_skeleton)
[![rake](https://github.com/matique/html_skeleton/actions/workflows/rake.yml/badge.svg)](https://github.com/matique/html_skeleton/actions/workflows/rake.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](http://choosealicense.com/licenses/mit/)

HtmlSkeleton provides the frame for a calendar or a table,
i.e. no loops are required to build up the HTML structure.
Filling the skeleton is done via parameters and, in particular,
with procs (Proc.new, lambda).
See below Default Options.

## Installation

As usual:
``` ruby
# Gemfile
gem "html_skeleton"
```
and run "bundle install".

## Calendar

A simple helper for creating an HTML calendar.
The "calendar" method will be available to your view templates.

Procs may be supplied to generate
particular HTML-code for a day or the year.
In the example below clicking a day triggers an action.

### Examples

``` ruby
HtmlSkeleton.new.calendar                  # calendar for current year
HtmlSkeleton.new.calendar year: 2012       # calendar for year 2012
HtmlSkeleton.new.calendar year: 2012, month: 8  # calendar for August 2012

HtmlSkeleton.new.calendar {|date|
  link = "/#{controller_name}/toggle/#{@resource.id}?date=#{date}"
  style = @resource.holidays.include?(date.to_s) ?
           'font-weight:bold; color:red' : ''
  %Q{ <a style="#{style}" href="#{link}"> #{date.day.to_s} </a>}
}
```

### Default Options

``` ruby
year:        DateTime.now.year,
title:       DateTime.now.year,
rows:        3,
calendar_class: 'skeleton',
day_names:   Date::DAYNAMES.dup,
month_names: Date::MONTHNAMES,
abbrev:      (0..1),
cell_proc:   block || ->(d) { d.day.to_s},
first_day_of_week: 1
```

Inspired by calendar_helper:

* Jeremy Voorhis -- http://jvoorhis.com
* Geoffrey Grosenbach -- http://nubyonrails.com


## Table

A simple helper for creating an HTML table.

Table only takes care of the HTML tags and expects lambdas/strings to
be supplied by the user.

### Examples

``` ruby
rows = %w{a bb ccc}
cols = %w{1 22}
HtmlSkeleton.new.table(rows, cols) {|row, col|
  col == '1' ? '<td>bingo</td>' : '<td></td>'
}
```

``` ruby
HtmlSkeleton.new.table(@users, %w{email address},
  th_attribute: lambda { |col| col.name },
  legend: 'Users') { |row, col| "<td>#{ row.send(col) }</td>" }
```

``` ruby
stripes = %w{odd even}
proc = ->(row) { k = stripes.shift; stripes << k; %Q{class="#{k}"} }
HtmlSkeleton.new.table(@users, %w{email address},
            tr_attribute: proc,
            legend: 'Users') { |row, col|
  "<td>#{ row.send(col) }</td>"
}
```

### Default Options

``` ruby
legend: nil,
col_legend:   ->(x) { x.to_s },
row_legend:   ->(x) { x.id },
th_attribute: ->(col) { nil },
tr_attribute: ->(row) { nil },
table_class:  'skeleton',
cell_proc:    block || ->(row, col) { "<td>#{row} #{col}</td>"}
```

## Curious?

- github.com/cthulhu666/easy_table
- github.com/giniedp/fancygrid
- github.com/hunterae/table-for
- github.com/jgdavey/tabletastic
- github.com/lunich/table_for
- github.com/watu/table_builder
- ruby-toolbox.com/projects/tableasy

## Miscellaneous

Copyright (c) 2012-2024 Dittmar Krall (www.matiq.com),
released under the [MIT license](https://opensource.org/licenses/MIT).
