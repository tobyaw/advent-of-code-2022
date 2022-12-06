#!/usr/bin/env ruby

input = File.read('day_06_input.txt').chars

puts [4, 14].map { |i| i + input.each_cons(i).find_index { |j| j.eql? j.uniq } }
