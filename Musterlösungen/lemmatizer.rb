# coding: utf-8
class Lemma 
  def initialize wf, le
    @wortformen = wf.is_a?(Array) ? wf : wf.split
    @lemmata = le.is_a?(Array) ? wf : le.split
  end


  def to_s
    "Der Lemmatisator enthält #{@wortformen.length} Wortfom- und #{@lemmata.length} Lemmaeinträge. #{@text}"
  end

  def lemmataEinlesen(datei)
    # liest die Celex-Lemmadatei (?ol) ein und erzeugt ein Array mit allen Lemmata
    # Feldnummer = Lemmanummer
    File.open(datei, 'r:ascii-8bit').each do |zeile|
      eintrag = zeile.chomp.split("\\")
      @lemmata[eintrag[0].to_i] = eintrag[1]
    end  # File.open
    puts "%d " % @lemmata.length + "Einträge eingelesen."
  end # lemmataEinlesen
  #
  def wortformenEinlesen(datei_w, datei_m)
    # liest die Celex-Wortform- und die Celexmorphologiedatei (?ow/?mw) ein und erzeugt ein Array,
    # dessen Felder Arrays der Länge 3 enthalten.
    # Sie haben die Form:      [Wortform, Lemmanummer, morphologische Informationen]
    File.open(datei_w,"r:ascii-8bit").each do |zeile|
      eintrag = zeile.chomp.split("\\")
      @wortformen[eintrag[0].to_i] = [eintrag[1], eintrag[3].to_i]
    end  # File.open
    File.open(datei_m,"r:ascii-8bit").each do |zeile|
      eintrag = zeile.chomp.split("\\")
      @wortformen[eintrag[0].to_i][2] = eintrag[4]
    end  # File.open
    puts "%d " % @wortformen.length + "Einträge eingelesen."
  end

  def lemmatisiere str
    text = File.file?(str) ? IO.read(str) : str
    text.split.each do |x|
      eintrag = @wortformen.assoc(x)
      if eintrag
        printf("%-20s : %-20s%-20s\n", eintrag[0], @lemmata[eintrag[1]], eintrag[2])
      else
        printf("%-20s : %-20s%-20s\n", x, x, '---')
      end
    end
  end

end
