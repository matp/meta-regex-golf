#!/usr/bin/env ruby

require_relative '../meta-regex-golf'

# Star Wars and Star Trek subtitles
positive = ["The Phantom Menace",
            "Attack of the Clones",
            "Revenge of the Sith",
            "A New Hope",
            "The Empire Strikes Back",
            "Return of the Jedi"].map(&:upcase)
negative = ["The Wrath of Khan",
            "The Search for Spock",
            "The Voyage Home",
            "The Final Frontier",
            "The Undiscovered Country",
            "Generations",
            "First Contact",
            "Insurrection",
            "Nemesis"].map(&:upcase)

mrg = MetaRegexGolf.new(positive, negative)
puts "/#{mrg.find_greedy}/"
