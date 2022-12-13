#!/usr/bin/env ruby

require 'json'

def compare(left, right)
  return if left.empty? && right.empty?
  return true if left.empty?
  return false if right.empty?

  lf = left.first
  rf = right.first

  case [lf, rf]
  in [Integer, Integer]
    return true if lf < rf
    return false if lf > rf
  else
    lf = [lf] if lf.instance_of?(Integer)
    rf = [rf] if rf.instance_of?(Integer)
    xyz = compare(lf, rf)
    return xyz if [true, false].include? xyz
  end

  compare(left.slice(1..), right.slice(1..))
end

input = File.read('day_13_input.txt')
            .split("\n\n")
            .map { |i| i.split("\n").map { |j| JSON.parse(j) } }

dividers = [2, 6].map { |i| [[i]] }

packets = input.reduce([]) { |acc, (i, j)| acc << i << j }
               .concat(dividers)
               .sort_by { |i| i.to_s.gsub(/\[\]/, '0').gsub(/[\[\]]/, '').split(', ').map(&:to_i) }

puts input.map.with_index { |(l, r), i| compare(l, r).eql?(true) ? i + 1 : 0 }
          .sum

puts dividers.map { |i| packets.index(i) + 1 }
             .reduce(:*)
