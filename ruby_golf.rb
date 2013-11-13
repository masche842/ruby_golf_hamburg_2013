# encoding: UTF-8
module RubyGolf

  ##############################################################################
  # Hole 1: RubyGolf.x_out_numbers                                             #
  ##############################################################################
  # input:  n - numbers string to be x'ed out,
  #         v - number of visible trailing numbers
  # output: x'ed out string
  def self.x_out_numbers(n, v)
    (x=n.size-v)<0 ? n : ('x'*(x<0?0:x)+n[-v..-1])
  end


  ##############################################################################
  # Hole 2: RubyGolf.underscore                                                #
  ##############################################################################
  # input:  an identifier string in camel case notation. i.e. 'SchinkenWurst'
  # ouput:  a 'ruby style' version of the identifier: all lowercase, former case
  #         changes to upper case get a prepended underscore
  def self.underscore(s)
    s.scan(/([A-Z]|^[a-z])([a-z]*)/).map{|a,b|a.downcase+b}.join('_')
  end


  ##############################################################################
  # Hole 3: RubyGolf.symbolize_keys                                            #
  ##############################################################################
  # input:  a hash
  # output: a hash where each key is a symbol.
  #         The values stay the same except they're hashes too.
  #         Values that are hashes contain only smybols as keys too, this
  #         condition is maintained recursivley
  def self.symbolize_keys(h)
    Hash[h.map{|a,b| b.is_a?(Hash) ? [a.to_sym,symbolize_keys(b)] : [a.to_sym,b] }]
  end

  ##############################################################################
  # Hole 4: RubyGolf.grid_computing                                            #
  ##############################################################################
  # input:  a grid of numbers between 00 and 99, separated by spaces, each row
  #         ending in a \n
  # output: the maximum value found by calculating the sums of all rows and
  #         columns
  def self.grid_computing(g)
    m = g.split("\n").map{|r|r.split.map{|t|t.to_i}}
    [m.size.times.map{|i| m.inject(0){|a,b| a+=b[i]}}.max,m.map{|a|a.reduce(:+)}.max].max
  end


  ##############################################################################
  # Hole 5: RubyGolf.reformat_hash                                             #
  ##############################################################################
  # input:  a string containing a hash expression possibly containing hash
  #         rockets
  # output: a string describing the same hash but without hash rockets, but
  #         otherwise with the same formatting
  def self.reformat_hash(s)
    s.gsub(/\:(\w+) =>/, '\1:')
  end


  ##############################################################################
  # Hole 6: RubyGolf.pretty_hash                                               #
  ##############################################################################
  # input:  a recursive hash mapping of strings or symbols ultimately to lists
  #         of strings or symbols
  # output: a formatted string containing the information of the hash where:
  #         * every line contains exactly one key or value
  #         * values are prefixed by a hyphen and a space
  #         * keys a suffixed with a colon
  #         * all keys or values that are contained in a hash that is not top
  #           level are prepended by two additional spaces per level away from
  #           the top level
  def self.pretty_hash(h)
    h.inject("") { |o,(a,b)|
      o<<"#{a}:\n"
      o<< b.inject("") { |u,(c,d)| u << (d ? "  #{c}:\n  - #{d.is_a?(Array) ? d.join("\n  - ") : d}\n" : "- #{c}\n")}}
  end


  ##############################################################################
  # Hole 7: RubyGolf.word_letter_sum                                           #
  ##############################################################################
  # input:  a string containing a list of space separated, letter-only words
  # output: independent of the case of the characters of the words the following
  #         value is calculated:
  #         * take the sum of the alphabetical positions of the characters of a
  #           word (A=1, B=2..)
  #         * sort the words by that sum - the one with the largest sum will be
  #           the first
  #         * multiply each sum with the position of its word in the list (first
  #           word 1* ...)
  #         * sum all products
  def self.word_letter_sum(s)
    s.downcase.split.map{ |w| w.chars.inject(0){|s,x|s+=x.ord-96}}.sort.reverse.map.with_index{|z,i|z*(i+1)}.reduce(:+)
  end


  ##############################################################################
  # Hole 8: RubyGolf.bob_ross                                                  #
  ##############################################################################
  # input:  a string defining an image, each line consisting of three values:
  #         * x coordinate
  #         * y coordinate
  #         * ascii value for that coordinate
  # output: an ascii art string ready for output where there aren't any trailing
  #         spaces after the last character in each line
  def self.bob_ross(s)
    m = s.split("\n").map{|a| a.split.map{|b| b.to_i}}
    m.sort_by{|a|a[0]}.inject('') do |a,b|
      out = " "*m.size
      out[b[1]] = b[2].chr
      a << out << "\n"
    end
  end

end
