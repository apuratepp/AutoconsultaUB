#!/usr/bin/env ruby

require 'lib/autoconsulta'

html = File.open 'tmp/ac.html'
notes_html = Autoconsulta::Parser.new html
notes_html.parse