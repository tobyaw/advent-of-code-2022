#!/usr/bin/env ruby

input = File.read('day_04_input.txt')
            .split("\n")
            .map { |i| i.split(',').map { |j| Range.new(*j.split('-').map(&:to_i)).to_a } }

puts input.filter { |i| i.include? i.reduce(:&) }.count
puts input.filter { |i| i.reduce(:&).count.positive? }.count
