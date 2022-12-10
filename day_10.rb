#!/usr/bin/env ruby

h = File.readlines('day_10_input.txt', chomp: true)
        .map(&:split)
        .each_with_object([1]) do |i, a|
  a.push a.last
  a.push(a.last + i[1].to_i) if i[0].eql? 'addx'
end

puts 20.step(by: 40, to: 220)
       .sum { |i| i * h[i - 1] }

240.times
   .map { |i| [i % 40, (h[i] - 1).upto(h[i] + 1)] }
   .map { |i, j| j.include?(i) ? '#' : '.' }
   .each_slice(40) { |i| puts i.join }
