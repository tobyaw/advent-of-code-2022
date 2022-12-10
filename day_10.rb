#!/usr/bin/env ruby

history = []

File.readlines('day_10_input.txt', chomp: true).map(&:split)
    .each.with_object({ x: 1 }) do |line, register|
  history.push register[:x]

  if line[0].eql? 'addx'
    history.push register[:x]
    register[:x] += line[1].to_i
  end
end

puts 20.step(by: 40, to: 220).sum { |i| i * history[i - 1] }

240.times
   .map { |i| (history[i] - 1).upto(history[i] + 1).include?(i % 40) ? '#' : '.' }
   .each_slice(40) { |i| puts i.join }
