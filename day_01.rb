#!/usr/bin/env ruby

calories_by_elf = File.read('day_01_input.txt')
                      .split("\n\n")
                      .map { |i| i.split("\n").map(&:to_i).sum }

puts calories_by_elf.max

puts calories_by_elf.max(3)
                    .sum
