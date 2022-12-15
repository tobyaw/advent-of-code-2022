#!/usr/bin/env ruby

[
  { filename: 'day_15_example.txt', y: 10 },
  { filename: 'day_15_input.txt', y: 2_000_000 }
].each do |run|
  input = File.readlines(run[:filename], chomp: true).map { |i| i.scan(/-?\d+/).map(&:to_i) }

  on_line = []
  exclude = []
  input.map do |sx, sy, bx, by|
    exclude << sx if sy.eql? run[:y]
    exclude << bx if by.eql? run[:y]

    distance = (sx - bx).abs + (sy - by).abs
    remainder = distance - (sy - run[:y]).abs
    next unless remainder.positive?

    on_line << ((sx - remainder)..(sx + remainder))
  end

  puts on_line.map(&:to_a).flatten.uniq.count - exclude.uniq.count
end
