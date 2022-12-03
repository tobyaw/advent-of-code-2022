#!/usr/bin/env ruby

pri = (('a'..'z').to_a + ('A'..'Z').to_a).zip((1..52)).to_h
inp = File.read('day_03_input.txt').split("\n").map(&:chars)
puts inp.map { |i| i.each_slice(i.size / 2).to_a }.map { |i| pri[(i[0] & i[1]).first] }.sum
puts inp.each_slice(3).map { |i| pri[(i[0] & i[1] & i[2]).first] }.sum
