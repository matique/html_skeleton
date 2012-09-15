# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "html_skeleton"
  s.version = "0.3.4"

  s.author   = 'Dittmar Krall'
  s.email    = 'dittmar.krall@matique.de'
  s.homepage = 'http://matique.de'

  s.summary  = "A simple helper for creating HTML calendars and tables"
  s.description = <<-DESCRIPTION
    A simple helper for creating HTML calendars and tables.

    An example in a view: <%= HtmlSkeleton.new.calendar %>

    The calendar/table may be embelished by user supplied Proc.new's,
    e.g. for inserting link_to.
  DESCRIPTION

  s.files = ['lib/html_skeleton.rb',
	     'lib/html_skeleton_calendar.rb',
	     'lib/html_skeleton_table.rb',
	     'README.md', 'MIT-LICENSE']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
#  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
end
