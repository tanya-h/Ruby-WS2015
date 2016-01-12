#!/usr/bin/ruby
#1204701

module Lemma


  def Lemma.read_split(filename, skip_first=false, skip_index=false)
    mama = []
    File.open(filename, "r") do |file|
      while line = file.gets
        line.chomp!
        if skip_index
          mama << line.split("\\")[1..-1]
        else
          mama << line.split("\\")
        end
      end
      if skip_first
        mama[0,0] = nil
      end
      mama
    end
  end


  def Lemma.generate_lexicon

    gol = read_split("/Users/tanya/Documents/STUDIUM/Scriptsprachen/gol.txt", true, true)
    gow = read_split("/Users/tanya/Documents/STUDIUM/Scriptsprachen/gow.txt", true, true)
    gsl = read_split("/Users/tanya/Documents/STUDIUM/Scriptsprachen/gsl.txt", true, true)
    gmw = read_split("/Users/tanya/Documents/STUDIUM/Scriptsprachen/gmw.txt", true, true)

    outfile = File.new("celex.txt", "w")

    res = []
    for inner, index in gow.each_with_index
      next if inner == nil
      tmp = []
      tmp[0] = inner[0] #wordform
      lemi = inner[2].to_i
      tmp[1] = gsl[lemi]? TAG_MAP[(gsl[lemi][2])] : nil #part of speech
      tmp[2] = gol[lemi][0] #lemma
      tmp[3] = gmw[index].last  #features
          res << tmp
      p tmp
      outfile.puts(tmp.join("\\"))
    end
    outfile.close
  end



  def Lemma.show_lexicon
    p LEX
  end


  def Lemma.lemmatize_tokenlist(tokenlist, arg=2)
    tokenlist.map do |t|

      bro = LEX.assoc(t)

      if bro
        if arg==0
          bro[2]
        elsif arg==1
          bro[2] + "\\" + (bro[1]) #lemma+part of speech
        elsif arg==2
            if  bro[1] == "KON" ||bro[1] == "ITJ" || bro[1] == "ART" ||
                bro[1]=="PRP" ||  bro[1]=="PRO" || bro[1]=="Q/N"
              "***"
              else bro[2]
            end
        end
      elsif t.size == 1
        "***"
      else t
      end
    end
  end


  def to_s
    "The lemmatizer's lexicon contains #{LEX.length} entries."
  end


  LEX = read_split("celex.txt")
  TAG_MAP = {
      "1" => "N", "2" => "ADJ", "3" =>"Q/N", "4" => "V", "5" => "ART",
      "6" => "PRO", "7" => "ADV", "8" => "PRP", "9" => "KON", "10" => "ITJ"
  }
end

#test
test = ["Sie", "hat", "viele", "kleine", "Sandwiches", "mitgebracht", "!"]
p test
p Lemma.lemmatize_tokenlist(test)
