require_relative 'tokenizer.rb'
require 'minitest/autorun'


class TestTokenizer < MiniTest::Test
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @doc1 = Document.new("")
    @doc2 = Document.new("der der der Der CSU")

  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.
  def teardown
    # Do nothing
  end

  def test_tokenizer

  end

  def test_tokenisiere_dokument

  end

  def test_tokenisiere
    assert_equal(['(','test',')'], @doc1.tokenisiere('(test)'))
    assert_equal(['test','?'], @doc1.tokenisiere('test?'))
  end

  def test_wort_normalerweise_klein?
    assert_equal(true, @doc2.wort_normalerweise_klein?('Der'))
    assert_equal(false, @doc2.wort_normalerweise_klein?('CSU'))
  end

  def test_endet_mit_abkuerzungspunkt?

  end

  def test_klassifiziere_punkte

  end

  def test_klass_pkt

  end


end