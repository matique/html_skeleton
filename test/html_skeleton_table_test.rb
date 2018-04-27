require 'rubygems'
require 'test/unit'
require File.expand_path('../test_helper', __FILE__)
require File.expand_path(File.dirname(__FILE__) + "../../lib/html_skeleton")

User = Struct.new(:id, :name, :email)

class HtmlSkeletonTableTest < Test::Unit::TestCase

  def test_html_table
    tab = a_table
    assert_not_nil tab
    assert_tag_count(tab, 'table', 1)
    assert_tag_count(tab, 'thead', 0)
    assert_tag_count(tab, 'tr', 3)
    assert_css_class(tab, 'table', 'skeleton')
  end

  def test_custom_css_class
    klass = 'custom'
    tab = a_table(table_class: klass)
    assert_css_class(tab, 'table', klass)
  end

  def test_cell_block
    tab = HtmlSkeleton.new.table(%w{a bb ccc}, %w{1 22}) { |row, col|
		col == '1' ? '<bingo></bingo>' : ''
	      }
    assert_tag_count(tab, 'bingo', 3)

    tab = HtmlSkeleton.new.table(%w{a bb ccc}, %w{1 22}) { |row, col|
		row == 'bb' ? '<bingo></bingo>' : ''
	      }
    assert_tag_count(tab, 'bingo', 2)
  end

  def test_with_legend
    tab = HtmlSkeleton.new.table(users, %w{name email},
	    legend: 'Users' ) {|row, col|
		  "<td>#{ row.send(col) }</td>"
    }
    assert_tag_count(tab, 'td', 6)
    assert_tag_count(tab, 'tr', 2)
    assert_match %r{Users}, tab
    assert_match %r{bob}, tab
  end

  def test_with_legend2
    stripes = %w{odd even}
    proc = lambda{ |row| k = stripes.shift; stripes << k; %Q{class="#{k}"} }
    tab = HtmlSkeleton.new.table(users, %w{name email},
	    tr_attribute: proc,
	    legend: 'Users' )
    assert_css_class(tab, 'tr', 'odd')
    assert_css_class(tab, 'tr', 'even')
  end


 private
  def a_table(options = {})
    HtmlSkeleton.new.table(%w{a bb ccc}, %w{1 22}, options)
  end

  def users
    [ User.new(1, 'bob', 'bob@sample.com'),
      User.new(2, 'tom', 'tom@sample.com') ]
  end
end
