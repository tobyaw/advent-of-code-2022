#!/usr/bin/env ruby

def combine_ranges(ranges)
  ranges.sort_by { |i| [i.first, i.last] }
        .each_with_object([]) do |i, arr|
    if arr.empty? || (i.first - arr[-1].last) > 1
      arr << i
    else
      arr[-1] = arr[-1].first..([arr[-1].last, i.last].max)
    end
  end
end

def part1(input)
  ranges = []
  beacons = []

  input.map do |sx, sy, bx, by|
    beacons << bx if by.eql? 2_000_000

    remainder = (sx - bx).abs + (sy - by).abs - (sy - 2_000_000).abs
    next unless remainder.positive?

    ranges << ((sx - remainder)..(sx + remainder))
  end

  combine_ranges(ranges).sum(&:size) - beacons.uniq.count
end

def part2(input)
  processed_input = input.map do |sx, sy, bx, by|
    distance = (sx - bx).abs + (sy - by).abs
    [sx, sy, distance]
  end

  x = nil
  y = 0.upto(4_000_000).find_index do |row|
    ranges = []
    processed_input.map do |sx, sy, distance|
      remainder = distance - (sy - row).abs
      next unless remainder.positive?

      r1 = sx - remainder
      r1 = 0 if r1.negative?
      next if r1 > 4_000_000

      r2 = sx + remainder
      r2 = 4_000_000 if r2 > 4_000_000
      next if r2.negative?

      ranges << (r1..r2)
    end

    combined_ranges = combine_ranges(ranges)
    x = combined_ranges.first.last + 1
    true if combined_ranges.count > 1
  end

  (x * 4_000_000) + y
end

input = File.readlines('day_15_input.txt', chomp: true)
            .map { |i| i.scan(/-?\d+/).map(&:to_i) }

puts part1_answer = part1(input)
raise unless part1_answer.eql? 6_425_133

puts part2_answer = part2(input)
raise unless part2_answer.eql? 10_996_191_429_555
