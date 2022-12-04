#!/usr/bin/env ruby

input = File.read('day_04_input.txt')
            .scan(/\d+/)
            .each_slice(2)
            .map { |i| Array(Range.new(*i)) }
            .each_slice(2)

puts input.filter { |i| i.include? i.reduce(:&) }
          .count
puts input.reject { |i| i.reduce(:&).empty? }
          .count
