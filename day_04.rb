#!/usr/bin/env ruby

numbers = ->(i) { [*i.first..i.last] }
input = File.read('day_04_input.txt').split("\n").map { |i| i.split(',').map { |j| numbers.call(j.split('-').map(&:to_i)) } }

puts input.filter { |i| i.include? i.inject(:&) }.count
puts input.filter { |i| i.inject(:&).count.positive? }.count
