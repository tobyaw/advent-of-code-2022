#!/usr/bin/env ruby

PRIORITY = [*('a'..'z'), *('A'..'Z')].zip((1..52)).to_h
input = File.read('day_03_input.txt').split("\n").map(&:chars)
puts input.map { |i| PRIORITY[i.each_slice(i.size / 2).reduce(:&).first] }.sum
puts input.each_slice(3).map { |i| PRIORITY[i.reduce(:&).first] }.sum
