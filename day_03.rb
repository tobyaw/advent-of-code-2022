#!/usr/bin/env ruby

priority = [*'a'..'z', *'A'..'Z'].zip(1..52)
                                 .to_h

input = File.readlines('day_03_input.txt', chomp: true)
            .map(&:chars)

puts input.sum { |i| priority[i.each_slice(i.size / 2).reduce(:&).first] }

puts input.each_slice(3)
          .sum { |i| priority[i.reduce(:&).first] }
