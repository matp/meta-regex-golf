#!/usr/bin/env ruby

class MetaRegexGolf
  attr_reader :expr

  def initialize(positive, negative)
    @positive = positive
    @negative = negative.reject {|n| positive.include?(n) }
    @expr = positive.join('|')
  end

  def false_negatives; @positive.select {|p| p !~ regexp(@expr) } end
  def false_positives; @negative.select {|n| n =~ regexp(@expr) } end

  def valid?(io = nil)
    fn, fp = false_negatives, false_positives
    io.puts "False negatives: #{fn.join(', ')}" if io && !fn.empty?
    io.puts "False positives: #{fp.join(', ')}" if io && !fp.empty?
    fn.empty? && fp.empty?
  end

  # Finds a regular expression that matches all of the positive but none
  # of the negative strings.
  def find_greedy(maxlength = 4)
    patterns = patterns(@positive, @negative, maxlength)
    strings  = @positive.clone
    expr     = ''

    until strings.empty? or patterns.empty?
      # pick the highest scoring pattern
      pattern = patterns.max_by {|p| score_greedy(strings, p) }
      # remove strings that are matched by this pattern
      strings.delete_if  {|s| s =~ regexp(pattern) }
      # remove patterns that don't match any of the remaining strings
      patterns.delete_if {|p| strings.none? {|s| s =~ regexp(p) } }

      expr += '|' unless expr.empty?
      expr += pattern
    end

    @expr = expr if strings.empty?
  end

  private

  # Score depending on length of the pattern and how many strings it matches
  def score_greedy(strings, pattern)
    strings.count {|s| s =~ regexp(pattern) } * 3 - pattern.length
  end

  # Patterns that mach some of the positive but none of the negative strings
  def patterns(positive, negative, maxlength = 0)
    positive.map    {|p| substrings("^#{p}$", maxlength) }.flatten.uniq
            .map    {|s| specials(s) }.flatten.uniq
            .select {|c| negative.none? {|n| n =~ regexp(c) } }
  end

  # '^ab$' -> ['^a', '^ab', '^ab$', 'a', 'ab', 'ab$', 'b', 'b$']
  def substrings(string, maxlength = 0)
    indices = *(0...string.length)
    indices.product(indices)
           .select {|x, y| x <= y && (maxlength == 0 || y - x < maxlength) }
           .map    {|x, y| string[x..y] }
           .reject {|s| '^$'.include? s }
  end

  # '^abc$' -> ['^..$', '^.b$', '^.b?$', '^a.$', '^ab$',
  #             '^ab?$', '^a?.$', '^a?b$', '^a?b?$']
  def specials(string)
    case string.length
    when 0 then []
    when 1 then '^$'.include?(string) ? [string] : ['.', string, "#{string}?"]
    else        specials(string[0]).product(specials(string[1..-1]))
                                   .map(&:join)
    end
  end

  # To allow reuse of regular expression objects
  def regexp(component)
    (@cache ||= {})[component] ||= Regexp.new(component)
  end
end
