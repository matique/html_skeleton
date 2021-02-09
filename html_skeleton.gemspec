Gem::Specification.new do |s|
  s.name = "html_skeleton"
  s.version = '0.5.2'

  s.author   = 'Dittmar Krall'
  s.email    = 'dittmar.krall@matique.de'
  s.homepage = 'http://matique.de'
  s.license  = 'MIT'

  s.summary  = 'A simple helper for creating HTML calendars and tables'
  s.description = <<-DESCRIPTION
    A simple helper for creating HTML calendars and tables.

    An example in a view: <%= HtmlSkeleton.new.calendar %>

    The calendar/table may be embelished by user supplied lambda's,
    e.g. for inserting link_to.
  DESCRIPTION

  s.files = ['lib/html_skeleton.rb',
	     'lib/html_skeleton_calendar.rb',
	     'lib/html_skeleton_table.rb',
	     'README.md', 'MIT-LICENSE']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']

  s.metadata['source_code_uri'] = 'https://github.com/matique/html_skeleton'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake', '~> 13'
end
