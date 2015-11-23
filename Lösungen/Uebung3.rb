#!/usr/bin/ruby
#1204701

class TextFilter


  def initialize(swear_words)
    if swear_words.is_a? String #is a string
      @wordlist = swear_words.split(/[ ,.;]/)
    else
      @wordlist = swear_words #is an array already
      end
  end


  #oneliner1
  def star_generator(string)
    string.replace("*"*string.length)
  end

  #oneliner2
  def star_generator2(string)
    string.gsub!(/./, '*')
  end


  def transcode(bad_string)
    tokens=bad_string.split(/(\W)/) #at the word border, preserving the spaces etc.
    tokens.each{ |t| if @wordlist.include?(t.downcase)
                        star_generator(t)
                     end }
    tokens.join
  end


  #more one-liners!
  def add_new_words(*word)
   @wordlist = @wordlist | word
  end

  attr_accessor :wordlist
  private :star_generator, :star_generator2

end


tf1 = TextFilter.new("crap shit poo")
tf2 = TextFilter.new(['bitch', 'idiot'])
tf2.add_new_words("jerk", "dumbo")

p tf1
p tf2
puts tf1.transcode("Shit! Where are my cookies! You little crap!")
puts tf2.transcode("Game over, dumbo.")



