#!/usr/bin/env ruby

priorities = (('a'..'z').to_a + ('A'..'Z').to_a).zip((1..52)).to_h
input = File.read('day_03_input.txt').split("\n")

puts input.map { |i| i.scan(/.{#{i.size / 2}}/) }
          .map { |i| priorities[(i[0].chars & i[1].chars).first] }
          .sum

puts input.each_slice(3)
          .map { |i| priorities[(i[0].chars & i[1].chars & i[2].chars).first] }
          .sum
