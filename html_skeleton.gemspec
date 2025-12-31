require_relative "lib/skeleton/version"

Gem::Specification.new do |s|
  s.name = "html_skeleton"
  s.version = Skeleton::VERSION

  s.author = "Dittmar Krall"
  s.email = "dittmar.krall@matiq.com"
  s.homepage = "https://github.com/matique/html_skeleton"
  s.license = "MIT"

  s.summary = "A simple helper for creating HTML calendars and tables"
  s.description = <<-DESCRIPTION
    A simple helper for creating HTML calendars and tables.

    An example in a view: <%= HtmlSkeleton.new.calendar %>

    The calendar/table may be embelished by user supplied lambda's,
    e.g. for inserting link_to.
  DESCRIPTION

  s.files = ["lib/html_skeleton.rb",
    "lib/html_skeleton_calendar.rb",
    "lib/html_skeleton_table.rb",
    "README.md", "MIT-LICENSE"]
  s.require_paths = ["lib"]
  s.required_ruby_version = ">= 3"

  s.add_development_dependency "minitest"
end
