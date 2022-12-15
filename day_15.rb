#!/usr/bin/env ruby

example1, part1 = [
  { filename: 'day_15_example.txt', y: 10 },
  { filename: 'day_15_input.txt', y: 2_000_000 }
].map do |run|
  ranges = []
  exclude = []

  File.readlines(run[:filename], chomp: true)
      .map { |i| i.scan(/-?\d+/).map(&:to_i) }
      .map do |sx, sy, bx, by|
    exclude << sx if sy.eql? run[:y]
    exclude << bx if by.eql? run[:y]

    distance = (sx - bx).abs + (sy - by).abs
    remainder = distance - (sy - run[:y]).abs
    next unless remainder.positive?

    ranges << ((sx - remainder)..(sx + remainder))
  end

  ranges.map(&:to_a).flatten.uniq.count - exclude.uniq.count
end

puts "Example 1 #{example1}"
puts "Part 1 #{part1}"

raise unless example1.eql? 26
raise unless part1.eql? 6_425_133
