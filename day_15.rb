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
    exclude << bx if by.eql? run[:y]

    distance = (sx - bx).abs + (sy - by).abs
    remainder = distance - (sy - run[:y]).abs
    next unless remainder.positive?

    ranges << ((sx - remainder)..(sx + remainder))
  end

  ranges = ranges.sort_by { |i| [i.first, i.last] }
                 .each_with_object([]) do |item, sum|
    if sum.empty? || sum.last.last < (item.first - 1)
      sum << item
    else
      sum[-1] = sum.last.first..([sum.last.last, item.last].max)
    end
  end

  exclude = exclude.uniq.reject { |i| ranges.index { |j| j.include? i }.nil? }

  ranges.reduce(0) { |sum, i| sum + i.size } - exclude.count
end

puts "Example 1 #{example1}"
puts "Part 1 #{part1}"

raise unless example1.eql? 26
raise unless part1.eql? 6_425_133

example2, part2 = [
  { filename: 'day_15_example.txt', limit: 20 },
  { filename: 'day_15_input.txt', limit: 4_000_000 }
].map do |run|
  input = File.readlines(run[:filename], chomp: true)
              .map { |i| i.scan(/-?\d+/).map(&:to_i) }

  x = nil
  y = 0.upto(run[:limit]).find_index do |row|
    puts row if (row % 100_000).eql? 0
    ranges = []

    input.map do |sx, sy, bx, by|
      distance = (sx - bx).abs + (sy - by).abs
      remainder = distance - (sy - row).abs
      next unless remainder.positive?

      r1 = sx - remainder
      r2 = sx + remainder
      next if r1 > run[:limit]
      next if r2.negative?

      r1 = 0 if r1.negative?
      r2 = run[:limit] if r2 > run[:limit]

      ranges << (r1..r2)
    end

    ranges = ranges.sort_by { |i| [i.first, i.last] }
                   .each_with_object([]) do |item, sum|
      if sum.empty? || sum.last.last < (item.first - 1)
        sum << item
      else
        sum[-1] = sum.last.first..([sum.last.last, item.last].max)
      end
    end

    response = false

    if ranges.count > 1
      x = ranges.first.last + 1
      response = true
    end

    response
  end

  puts "row #{x} column #{y}"

  puts "x #{x} y #{y}"
  (x * 4_000_000) + y
end

puts "Example 2 #{example2}"
puts "Part 2 #{part2}"

raise unless example2.eql? 56_000_011
raise unless part2.eql? 10_996_191_429_555
