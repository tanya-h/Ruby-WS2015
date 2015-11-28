#!/usr/bin/ruby
#1204701
#quick and dirty this time

class Document

  def initialize (input)
    @text=input
    @token_list=text.split
    tokenize_all
    @known_abbreviations = ["U.S.A", "N.Y", "a.k.a", "etc.", "i.e."]
  end


  def self.tokenize(string)
    string.split(/([+=\*\&\%\$\#\@\<\>;:?!,\{\}\[\]\)\(])/).keep_if{|t| t!=""}
  end


  def tokenize_all
    @token_list.map! {|t| Document.tokenize(t)} # result of tokenize => 2d array
    @token_list.flatten! # turn @token_list into 1d array again
  end


  def case (token)
    res=Array.new(2)
    res[0]=@token_list.count(token.capitalize)
    res[1]=@token_list.count(token.downcase)
    res
  end


  def context (token, before, after)
    index=@token_list.index(token)
    @token_list.values_at(index-before..index+after)
  end

  attr_reader :text, :known_abbreviations
  private :tokenize_all

end
