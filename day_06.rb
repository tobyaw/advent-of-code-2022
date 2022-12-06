#!/usr/bin/env ruby

input = File.read('day_06_input.txt').chars
[4, 14].each do |length|
  puts input.each_cons(length).with_index
            .find { |i| i.first.uniq.count.eql? length }
            .last + length
end
