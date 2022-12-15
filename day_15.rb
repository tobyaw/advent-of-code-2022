#!/usr/bin/env ruby

def part1
  ranges = []
  exclude = []

  File.readlines('day_15_input.txt', chomp: true)
      .map { |i| i.scan(/-?\d+/).map(&:to_i) }
      .map do |sx, sy, bx, by|
    exclude << bx if by.eql? 2_000_000

    remainder = (sx - bx).abs + (sy - by).abs - (sy - 2_000_000).abs
    next unless remainder.positive?

    ranges << ((sx - remainder)..(sx + remainder))
  end

  ranges = ranges.sort_by { |i| [i.first, i.last] }
                 .each_with_object([]) do |item, sum|
    if sum.empty? || sum[-1].last < (item.first - 1)
      sum << item
    else
      sum[-1] = sum[-1].first..([sum[-1].last, item.last].max)
    end
  end

  exclude = exclude.uniq.reject { |i| ranges.index { |j| j.include? i }.nil? }
  ranges.reduce(0) { |sum, i| sum + i.size } - exclude.count
end

def part2
  input = File.readlines('day_15_input.txt', chomp: true)
              .map { |i| i.scan(/-?\d+/).map(&:to_i) }
              .map do |sx, sy, bx, by|
    distance = (sx - bx).abs + (sy - by).abs
    [sx, sy, bx, by, distance]
  end

  x = nil
  y = 0.upto(4_000_000).find_index do |row|
    ranges = []

    input.map do |sx, sy, _bx, _by, distance|
      remainder = distance - (sy - row).abs
      next unless remainder.positive?

      r1 = sx - remainder
      next if r1 > 4_000_000

      r1 = 0 if r1.negative?

      r2 = sx + remainder
      next if r2.negative?

      r2 = 4_000_000 if r2 > 4_000_000

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

    x = ranges.first.last + 1
    true if ranges.count > 1
  end

  (x * 4_000_000) + y
end

puts part1_answer = part1
raise unless part1_answer.eql? 6_425_133

puts part2_answer = part2
raise unless part2_answer.eql? 10_996_191_429_555
