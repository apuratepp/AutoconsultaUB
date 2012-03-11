module Autoconsulta
  class Parser
    Nota        = Struct.new(:curs, :semestre, :codi, :assignatura, :grup, :nota, :nota2, :credits, :apunt, :tipus)
    Ensenyament = Struct.new(:codi, :nom, :tipus)
    
    def initialize(html_autoconsulta)

    end
    
    def self.parse_notes(html_autoconsulta)
      notes = []

      doc = Nokogiri::HTML.parse(html_autoconsulta)
      taula_notes = doc.search('table')[9]
      fila_notes = taula_notes.search('tr').each_with_index do |fila, index|
        elements = fila.search('td')
        if index > 0
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
      end
      notes
    end
    
    def self.parse_ensenyaments(html_ensenyaments)
      ensenyaments = []
      
      doc = Nokogiri::HTML.parse(html_ensenyaments)
      taula_ensenyaments = doc.search('table')[3]
      taula_ensenyaments.search('tr').each_with_index do |fila, index|
        if index > 0
          elements = fila.search('td')
          ensenyaments << Ensenyament.new(
            elements[0].child['value'],
            elements[1].content,
            elements[2].content
          )
        end
      end
      doc.search('input').each do |input|
        if input['type'] == "hidden"
          @phpsessid = input['value']
        end
      end
      [ensenyaments, @phpsessid]
    end
  
  end
end