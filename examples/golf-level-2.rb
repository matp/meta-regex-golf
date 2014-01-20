#!/usr/bin/env ruby

require_relative '../meta-regex-golf'

# Level 2 of http://regex.alf.nu/
positive = %w[Mick Rick allocochick backtrick bestick candlestick counterprick
              heartsick lampwick lick lungsick potstick quick rampick rebrick
              relick seasick slick tick unsick upstick]
negative = %w[Kickapoo Nickneven Rickettsiales billsticker borickite chickell
              fickleness finickily kilbrickenite lickpenny mispickel quickfoot
              quickhatch ricksha rollicking slapsticky snickdrawing sunstricken
              tricklingly unlicked unnickeled]

mrg = MetaRegexGolf.new(positive, negative)
puts "/#{mrg.find_greedy}/"
