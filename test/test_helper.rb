if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/test/'
  end
end

#require 'rails/test_help'
#require 'minitest/autorun'
##require 'minitest/benchmark'
##require 'capybara/rails'

class Test::Unit::TestCase
 private

  def assert_tag_count(str, tag, count)
    arr = str.split(/<#{tag}[[:^alpha:]]/)
    assert_equal count, arr.length - 1
  end

  def assert_css_class(str, tag, css_class)
    assert_match %r{#{tag} class="#{css_class}"}, str
  end

end
