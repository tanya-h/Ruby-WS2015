#!/usr/bin/ruby
#1204701

class Lemma

  attr_reader :wordforms, :lemmas

  def initialize(wordforms_array, lemma_array)
    @wordforms = wordforms_array
    @lemmas = lemma_array
  end


  def to_s
    "The lemmatizer contains #{@wordforms.length} wordform- and #{@lemmas.length} lemma entries."
  end


  def lemmatize_string(string)

    string.split.map do |s|
      wf= @wordforms.assoc(s.downcase) #ACHTUNG: assoc compares the first elem of enclosed array in nD arrays
      if wf!=nil
      index= wf[1]
      replacement=@lemmas[index]
      replacement
      else s
      end
    end
  end

end

#test
lemmatizer = Lemma.new([["led", 2, "V"], ["genius's", 1,"ADJ"], ["dairies", 0, "N"]],
                       ["dairy", "genius", "lead"])
out = lemmatizer.lemmatize_string("Salvador Dali led genius's dairies ")
p out


