# Autoconsulta UB
Parsejador de la pàgina de l'expedient de la Universitat de Barcelona

## Com utilitzar l'script

```ruby
config = YAML::load(File.open('config.yml'))
consulta = Autoconsulta::Connect.new  :niub => config['niub'], 
                                      :danaix => config['danaix'], 
                                      :idensy => config['idensy'], 
                                      :user => config['user'], 
                                      :pass => config['pass']

notes = consulta.get_notes
p notes.last # => #<struct Autoconsulta::Parser::Nota curs="2010", semestre="2", codi="230067", assignatura="FISICA COMPUTACIONAL", grup="T1", nota="Notable", nota2="-", credits="  7,50", apunt="ORDINARI", tipus="Optativa">
```