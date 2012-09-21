#!/usr/bin/env ruby

require 'yaml'
require 'lib/autoconsulta'

config = YAML::load(File.open('config.yml'))

consulta = Autoconsulta::Connect.new  :niub => config['niub'], 
                                      :danaix => config['danaix'], 
                                      :idensy => config['idensy'], 
                                      :user => config['user'],
                                      :pass => config['pass']

# ensenyaments = consulta.get_ensenyaments
# ensenyaments.each do |en|
#   puts en.codi + ": " + en.nom
# end

notes = consulta.get_notes
notes.each do |nota|
  puts "#{nota.curs} - #{nota.assignatura}: #{nota.nota} / #{nota.nota2}"
end