text = "Die Zentrale der CSU in (zB.) München ist in die Jahre gekommen, aber ein Plakat vor dem Eingang macht derzeit deutlich, wie sich die Christsozialen modern zeigen wollen: \"Freunde für Bayern - Jetzt. Mehr. Erleben\". Dazu gibt es den Verweis auf eine Facebook-Seite. Sie begrüßt den Besucher mit einem Foto, auf dem eine Gruppe junger Leute mit Rucksäcken durch einen Fluss watet. \"Servus! Lass uns Freunde werden\", heißt es auf der Seite im Internet. Freunde, das wären im Sinne der CSU wohl nicht nur Wähler, sondern auch neue Mitglieder - und um die soll künftig stärker geworben werden. So sieht es der Leitantrag für den Parteitag im Dezember vor. Der CSU-Vorstand hat sich an diesem Montag auf das Papier verständigt. Es soll unter anderem ein Online-Aufnahmeverfahren eingeführt werden. Zudem will die Parteiführung mehr Mitglieder ihrer Arbeitsgemeinschaften in die Mutterpartei locken. Bisher kann man der Frauen-, Senioren- und Jungen Union angehören, ohne in der CSU zu sein. \"Hierfür wird das Instrument der Probemitgliedschaft in die Satzung eingeführt.\", heißt es im Leitantrag. Neumitglieder in den Arbeitsgemeinschaften sollen demnach für zwei Jahre Probemitglied in der CSU werden. Es gehe darum, mit unkonventionellen Wegen neue Mitglieder zu gewinnen, sagte CSU-Chef Horst Seehofer."


class Document
  attr_accessor :text, :token_list

  def initialize(doc)
    @text = doc
    @token_list = doc.split
    @bekannte_abkuerzungen = []
    @veraendert = nil        # Diese boolesche Variable wird verwendet um zu überprüfen, ob ein oder mehrere Token
                             # noch am Ende einen Punkt enthalten, die durch die Punktdisambiguierung
                             # (klassifiziere_punkte) noch zu behandeln sind.
  end

  def to_s
    puts @text[0..70] + "..."
    puts @token_list[0..9] << "..."
  end


  def tokenizer
    begin
      @veraendert = nil
      klassifiziere_punkte
      tokenisiere_dokument
    end while @veraendert
    @token_list
  end


  def tokenisiere_dokument
    neue_liste = []
    @token_list.each do |x|
      neue_liste += tokenisiere(x)
    end
    @token_list = neue_liste
  end

  def tokenisiere (token)
    if (token.length > 1) #and (token =~ /[a-zA-Z][a-zA-Z]/)
      if ['(',"\'","\""].include?(token[0])
        [token[0]] + tokenisiere(token[1..-1])
      elsif [")","\'","\"",":",";",",","!","?"].include?(token[-1]) #,"." entfernt
        tokenisiere(token[0...-1]) + [token[-1]]
      else
        # nur hier muss geprüft werden, ob am Ende des Tokens noch ein Punkt steht, der eventuell zu entfernen ist
        @veraendert = true if token[-1] == '.'
        [token]
      end
    else
      [token]
    end
  end

  def wort_normalerweise_klein?(token)
    tok_up = @token_list.count(token)
    tok_dwn = @token_list.count(token.downcase)
    if tok_up > 0
      tok_dwn / tok_up >= 0.5
    end
  end

  def endet_mit_abkuerzungspunkt? token
    token.count('.') * (1 / (2.7182818 ** token.length)) * (1 / token.length ** @token_list.count(token[0...-1]).to_f) > 0.03
  end

  def klassifiziere_punkte
    neue_liste = []
    @token_list.each_with_index { |x,i | if (x[-1] == "." and (x.length > 1)); neue_liste += klass_pkt(x, @token_list[i+1]) else neue_liste << x end}
    @token_list = neue_liste
  end

  def klass_pkt(tk1, tk2)
    if tk2
      # Das zweite Wort beginnt mit einem Kleinbuchstaben oder das erste Wort ist eine bekannte Abkürzung
      if (tk2 =~ /^[a-z]/) || (@bekannte_abkuerzungen.include?(tk1))
        [tk1]
        # Das zweite Wort beginnt mit einem Großbuchstaben, wird aber oft kleingeschrieben => Satzendezeichen
      elsif wort_normalerweise_klein?(tk2)
        #[tk1[0...-1], tk1[-1]] #
        tokenisiere(tk1[0...-1]) << tk1[-1]
        # Die vereinten Gewichte legen nah, dass es sich um eine Abkürzung handelt
      elsif endet_mit_abkuerzungspunkt? tk1
        [tk1]
        # Das nächste Token ist ein Sonderzeichen
      elsif ['(',')',',',';',':','-'].include?(tk1)
        [tk1]
      else
        # [tk1[0...-1], tk1[-1]]
        tokenisiere(tk1[0...-1]) << tk1[-1]
      end
    else
      # [tk1[0...-1], tk1[-1]]
      tokenisiere(tk1[0...-1]) << tk1[-1]
    end
  end

end



test = Document.new(text)

# puts test.klassifiziere_punkte
# puts test.tokenisiere_dokument
# puts test.klassifiziere_punkte

test.tokenizer

# puts test.token_list

# puts "eingeführt\"" =~ /[a-zA-Z][a-zA-Z]/

# test2 = Document.new("eingeführt\"")

# puts test.tokenisiere("eingeführt\"")

# puts test.wort_normalerweise_klein?('CSU')

p test.tokenisiere('Haus')
p test.tokenisiere('Haus.')
p test.tokenisiere('(Haus.)')
p test.tokenisiere('(z.B.)')
p test.tokenisiere('z.B.')
