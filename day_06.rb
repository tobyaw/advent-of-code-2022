#!/usr/bin/env ruby

def process(input, length)
  input.each_cons(length)
       .map.with_index { |i, j| [i, j] }
       .select { |i| i.first.uniq.count.eql? length }
       .map(&:last)
       .first + length
end

input = File.read('day_06_input.txt').chars
puts process(input, 4)
puts process(input, 14)
