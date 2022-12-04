#!/usr/bin/env ruby

input = File.read('day_04_input.txt').split("\n")
            .map { |i| i.split(/[,-]/).map(&:to_i).each_slice(2).map { |j| [*Range.new(*j)] } }

puts input.filter { |i| i.include? i.reduce(:&) }.count
puts input.filter { |i| i.reduce(:&).count.positive? }.count
