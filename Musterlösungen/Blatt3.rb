# Musterlösung zu Aufgabenblatt (3)

class Textfilter

  attr_accessor :wortliste

  def initialize spam_woerter
    @wortliste = if spam_woerter.is_a?(Array); spam_woerter else spam_woerter.split end
  end


  def to_s
    puts "Der Spamfilter enthält folgende Wörter:"
    @wortliste.each { |x| print x + ' ' }
  end

  def star_generator token
    wrd = ""
    token.each_char { |x| wrd += '*' }
    wrd
  end

  def transcode message
    str = ""
    message.split.each do |x|
      if @wortliste.include?(x)
        str += star_generator(x) + ' '
      else
        str += x + ' '
      end
    end
    str
  end

  def neue_woerter str
    @wortliste += if str.is_a?(Array); str else str.split end
  end

end


test_filter = Textfilter.new(['Mist', 'Shit'])

puts test_filter.wortliste

test_filter.star_generator('Misthaufen')

puts test_filter.transcode('Der Mist stank zum Himmel!')

test_filter.neue_woerter('stank')

puts test_filter.transcode('Der Mist stank zum Himmel!')
