#!/usr/bin/env ruby

require_relative '../meta-regex-golf'

# Level 1 of http://regex.alf.nu/
positive = %w[afoot catfoot dogfoot fanfoot foody foolery foolish fooster
              footage foothot footle footpad footway hotfoot jawfoot mafoo
              nonfood padfoot prefool sfoot unfool]
negative = %w[Atlas Aymoro Iberic Mahran Ormazd Silipan altared chandoo
              crenel crooked fardo folksy forest hebamic idgah manlike
              marly palazzi sixfold tarrock unfold]

mrg = MetaRegexGolf.new(positive, negative)
puts "/#{mrg.find_greedy}/"
