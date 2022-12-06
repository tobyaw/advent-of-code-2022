#!/usr/bin/env ruby

input = File.read('day_06_input.txt').chars

[4, 14].each do |i|
  puts input.each_cons(i).with_index
            .find { |j| j.first.uniq.count.eql? i }
            .last + i
end
