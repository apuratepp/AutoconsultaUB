#!/usr/bin/env ruby

require 'yaml'
require 'lib/autoconsulta'

config = YAML::load(File.open('config.yml'))

connection = Autoconsulta::Connect.new  :niub => config['niub'], 
                                        :danaix => config['danaix'], 
                                        :idensy => config['idensy'], 
                                        :user => config['user'], 
                                        :pass => config['pass']

ensenyaments = connection.get_ensenyaments
ensenyaments.each do |en|
  puts en.codi + ": " + en.nom
end

notes = connection.get_notes
notes.each do |nota|
  puts nota.curs
  puts nota.assignatura
  puts nota.nota
end