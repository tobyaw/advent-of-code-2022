#!/usr/bin/env ruby

require 'json'

def compare(left, right)
  return if left.empty? && right.empty?
  return true if left.empty?
  return false if right.empty?

  heads = [left.first, right.first]

  case heads
  in [Integer, Integer]
    return true if heads.reduce(:<)
    return false if heads.reduce(:>)
  else
    heads.map! { |i| i.instance_of?(Integer) ? [i] : i }
    comp = compare(heads[0], heads[1])
    return comp if [true, false].include? comp
  end

  compare(left.slice(1..), right.slice(1..))
end

input = File.read('day_13_input.txt').split("\n\n")
            .map { |i| i.split("\n").map { |j| JSON.parse(j) } }

dividers = [2, 6].map { |i| [[i]] }
packets = [nil] + input.reduce([]) { |acc, (i, j)| acc << i << j }.concat(dividers)
                       .sort_by { |i| i.to_s.gsub(/\[\]/, '0').gsub(/[\[\]]/, '').split(', ').map(&:to_i) }

puts input.map.with_index(1) { |(l, r), i| compare(l, r) ? i : 0 }.sum
puts dividers.map { |i| packets.index(i) }.reduce(:*)