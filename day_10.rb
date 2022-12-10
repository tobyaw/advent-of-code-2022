#!/usr/bin/env ruby

h = [1]

File.readlines('day_10_input.txt', chomp: true).map(&:split).each do |i|
  h.push h.last
  h.push(h.last + i[1].to_i) if i[0].eql? 'addx'
end

puts 20.step(by: 40, to: 220).sum { |i| i * h[i - 1] }

240.times
   .map { |i| -1.upto(1).map { |j| j + h[i] }.include?(i % 40) ? '#' : '.' }
   .each_slice(40) { |i| puts i.join }
