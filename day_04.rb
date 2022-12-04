#!/usr/bin/env ruby

input = File.read('day_04_input.txt')
            .split(/[\n,-]/)
            .map(&:to_i)
            .each_slice(2)
            .map { |i| [*Range.new(*i)] }
            .each_slice(2)

puts input.filter { |i| i.include? i.reduce(:&) }
          .count

puts input.reject { |i| i.reduce(:&).empty? }
          .count
