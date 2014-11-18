class Document
  attr_accessor :text, :token_list

  def initialize(doc)
    @text = doc
    @token_list = doc.split
  end

  def to_s
    puts @text[0..70] + "..."
    puts @token_list[0..9] << "..."
  end

  def tokenisiere_dokument #(token_array)
    neue_liste = []
    @token_list.each do |x|
      neue_liste += tokenisiere(x)
    end
    @token_list = neue_liste
    p neue_liste
  end

end


def tokenisiere (token)
  if (token.length > 3) and (token =~ /[a-zA-Z][a-zA-Z]/)
    if ['(',"\'","\""].include?(token[0])
      [token[0]] + tokenisiere(token[1..-1])
    elsif [')','\'','\"',".",":",";",",","!","?"].include?(token[-1])
      tokenisiere(token[0...-1]) + [token[-1]]
    else
      [token]
    end
  else
    [token]
  end
end
