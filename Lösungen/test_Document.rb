#!/usr/bin/ruby
#1204701

require 'minitest/autorun'
require_relative 'Uebung4.rb'

class DocumentTest < MiniTest::Unit::TestCase


  def test_abbreviations
    assert(!Document.new("").known_abbreviations.empty?, "list of know abbreviations is empty")
  end

  def test_simple
      assert_equal(["Hello."], Document.tokenize("Hello."))
      assert_equal(["Hello","!"], Document.tokenize("Hello!"))
      assert_equal(["Hello", ";"], Document.tokenize("Hello;"))
  end

  def test_many_periods
    assert_equal(["U.S.A."], Document.tokenize("U.S.A."))
    assert_equal(["U.S.A..."], Document.tokenize("U.S.A..."))
    assert_equal(["U...S...A..."], Document.tokenize("U...S...A..."))

  end

  def test_brackets
    assert_equal(["{", "Hello"], Document.tokenize("{Hello"))
  end

  def test_enclosed_brackets
    assert_equal(["(","{","[","Hello","]","}",")"], Document.tokenize("({[Hello]})"))

  end

  def test_compounds
    assert_equal(["marry-go-round"], Document.tokenize("marry-go-round"))
  end

end