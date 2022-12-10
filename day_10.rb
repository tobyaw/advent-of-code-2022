#!/usr/bin/env ruby

h = File.readlines('day_10_input.txt', chomp: true)
        .each_with_object([1]) do |i, a|
  a << a.last
  a << (a.last + i.split.last.to_i) if i.start_with? 'addx'
end

puts 20.step(by: 40, to: 220)
       .sum { |i| i * h[i - 1] }

240.times
   .map { |i| (h[i] - (i % 40)).abs < 2 ? '#' : '.' }
   .each_slice(40) { |i| puts i.join }
