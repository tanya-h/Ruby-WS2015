#!/usr/bin/ruby
#1204701



#Aufgabe1
#a) eigene Variante
def befehlsgenerator(str)
  if str.end_with?('.')
    str.sub!(/(.)\.\z/, '\1!')  #=> ersetzt NUR den letzten Punkt in-place

     #str.sub!(/\./, '!')       #=> ersetzt den ersten gefundenen Punkt in-place
     #str.gsub!(/\./, '!')      #=> alle Vorkommen vom Punkt werden esrsetzt
  else
    "Failure to generate einen Befehl: bad input"
  end
end
puts befehlsgenerator 'Good input. Very good input.'
puts befehlsgenerator 'An intentionally bad input'


#b) in der Übung abfehörte Variante
def befehlsgenerator2(str)
  if str[-1] == "."
    str[-1] = "!"
  end
  str
end
puts befehlsgenerator2('Do same as above.')
puts befehlsgenerator2("Whaat?")



#Aufgabe2
def zinseszinns(geldbetrag, zinnssatz, anlagedauert)
  geldbetrag * ((1+zinnssatz/100.0)**anlagedauert)
end
puts zinseszinns 1000, 5, 2



#Aufgabe3
def tokenisiere_string(str)
  split = str.split
  split.each{|token| puts token}
end
tokenisiere_string("Mama mia, hat geklappt!")



#Aufgabe4
def string_to_hash(str)
  split = str.split
  map = { }
  split.each{|token| if map.include?(token)   #for longer blocks: instead of {} do.. ends
                       map[token]+=1
                     else
                        map.store(token,1)
                     end}
  p map
end
string_to_hash("bla bla und bla")

