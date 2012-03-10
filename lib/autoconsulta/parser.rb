module Autoconsulta
  class Parser
    Nota = Struct.new(:curs, :semestre, :codi, :assignatura, :grup, :nota, :nota2, :credits, :apunt, :tipus)
    
    def initialize(html_autoconsulta)
      @html_autoconsulta = html_autoconsulta
    end
    
    def parse
      notes = []

      doc = Nokogiri::HTML.parse(@html_autoconsulta.read)
      taula_notes = doc.search('table')[9]
      fila_notes = taula_notes.search('tr')
      fila_notes.each do |fila|
        elements = fila.search('td')
        notes << Nota.new(
          elements[0].content,
          elements[1].content,
          elements[2].content,
          elements[3].content,
          elements[4].content,
          elements[5].content,
          elements[6].content,
          elements[7].content,
          elements[8].content,
          elements[9].content
        )
      end
      puts notes[10].assignatura + ": " + notes[10].nota
    end
  
  end
end