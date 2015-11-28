#!/usr/bin/ruby
#1204701

#Aufgabe1
#ich bin einen Schritt weiter gegangen
#und lese aus einer Dateu
class Document

  attr_reader :content

  def initialize (filename)
    file=open(filename)
    @content=file.read
  end


  def case (token)
    tokens=content.split(/[ \n;:\"'`.,?!]/).to_a
    p tokens
    res=Array.new(2)
    res[0]=tokens.count(token.capitalize) #res[0]=tokens.count{ isUpperCase(token)}
    res[1]=tokens.count(token.downcase)
    res
  end


#Aufgabe2
  def context (token, before, after)
    tokens=content.split(/[ \n;:\"'`.,?!]/).to_a
    index=tokens.index(token)
    #wenn nicht gefunden - nil!!!!
    tokens.values_at(index-before..index+after)
  end
end



def isCapitalized(token)
   /[[:upper:]]/.match(token[0]) != nil
end


doc = Document.new("text.txt")
p doc
p doc.case("do")
p doc.context("Unix", 4, 8)

p isCapitalized("mom")
p isCapitalized("Mom")
