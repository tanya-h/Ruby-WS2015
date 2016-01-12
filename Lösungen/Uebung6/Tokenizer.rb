#!/usr/bin/ruby
#1204701

module Tokenizer

  def Tokenizer.tokenize(string)
    string.split(/([+=\*\&\%\$\#\@\<\>;:?!,\{\}\[\]\)\(])/).keep_if{|t| t!=""}
  end


  def Tokenizer.tokenize_all(text)
    token_list=text.split
    token_list = token_list.map {|t| self.tokenize(t)} # result of tokenize => 2d array
    token_list.flatten! # turn @token_list into 1d array again
  end

  attr_reader :KNOWN_ABBR
  KNOWN_ABBR = ["usw.", "z.B.", "u.a.", "i.d.R", "i.A.", "bzw.", "evtl.", "d.h.", "bspw.", "vgl."]

end
