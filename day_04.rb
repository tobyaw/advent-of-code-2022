#!/usr/bin/env ruby

input = File.readlines('day_04_input.txt', chomp: true)
            .map { |i| i.split(/[,-]/).map(&:to_i).each_slice(2).map { |j| [*Range.new(*j)] } }

puts input.filter { |i| i.include? i.reduce(:&) }.count
puts input.reject { |i| i.reduce(:&).empty? }.count
