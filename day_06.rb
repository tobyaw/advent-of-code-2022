#!/usr/bin/env ruby

input = File.read('day_06_input.txt').chars

[4, 14].each do |i|
  puts i + input.each_cons(i).with_index
                .find { |j, _| j.eql? j.uniq }
                .last
end
