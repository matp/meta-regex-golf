#!/usr/bin/env ruby

require_relative '../meta-regex-golf'

# Winners and losers of US presidential elections
positive = %w[adams buchanan bush carter cleveland clinton coolidge eisenhower
              garfield grant harding harrison hayes hoover jackson jefferson
              johnson kennedy lincoln madison mckinley monroe nixon obama
              pierce polk reagan roosevelt taft taylor truman vanburen
              washington wilson]
negative = %w[adams blaine breckinridge bryan bush carter cass clay cleveland
              clinton cox davis dewey dole dukakis fillmore ford goldwater
              gore greeley hancock harrison hoover hughes humphrey jackson
              jefferson kerry king landon mccain mcclellan mcgovern mondale
              nixon parker pinckney romney roosevelt scott seymour smith
              stevenson tilden vanburen wilkie]

mrg = MetaRegexGolf.new(positive, negative)
puts "/#{mrg.find_greedy}/"
