#!/usr/bin/env ruby

require 'json'

def compare(left, right)
  return true if left.empty? && !right.empty?
  return false if !left.empty? && right.empty?
  return 'continue' if left.empty? && right.empty?

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

puts input.map.with_index { |(l, r), i| compare(l, r).eql?(true) ? i + 1 : 0 }
          .sum
