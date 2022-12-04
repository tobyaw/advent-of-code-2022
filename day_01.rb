#!/usr/bin/env ruby

input = File.read('day_01_input.txt')
            .split("\n\n")
            .map { |i| i.split("\n").sum(&:to_i) }

puts input.max

puts input.max(3)
          .sum
