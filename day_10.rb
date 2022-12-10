#!/usr/bin/env ruby

history = [1]

File.readlines('day_10_input.txt', chomp: true).map(&:split).each do |line|
  history.push history.last
  history.push(history.last + line[1].to_i) if line[0].eql? 'addx'
end

puts 20.step(by: 40, to: 220).sum { |i| i * history[i - 1] }

240.times
   .map { |i| (history[i] - 1).upto(history[i] + 1).include?(i % 40) ? '#' : '.' }
   .each_slice(40) { |i| puts i.join }
