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
    arr_heads = heads.map { |i| i.instance_of?(Integer) ? [i] : i }
    arr_comp = compare(arr_heads[0], arr_heads[1])
    return arr_comp if [true, false].include? arr_comp
  end

  compare(left.slice(1..), right.slice(1..))
end

input = File.read('day_13_input.txt').split("\n\n")
            .map { |i| i.split("\n").map { |j| JSON.parse(j) } }

dividers = [2, 6].map { |i| [[i]] }

packets = input.reduce([]) { |acc, (i, j)| acc << i << j }.concat(dividers)
               .sort_by { |i| i.to_s.gsub(/\[\]/, '0').gsub(/[\[\]]/, '').split(', ').map(&:to_i) }

puts input.map.with_index { |(l, r), i| compare(l, r) ? i + 1 : 0 }.sum
puts dividers.map { |i| packets.index(i) + 1 }.reduce(:*)
