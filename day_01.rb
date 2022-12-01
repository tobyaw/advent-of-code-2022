#!/usr/bin/env ruby

calories_by_reindeer = File.read('day_01_input.txt')
                           .split("\n\n")
                           .map { |i| i.split("\n").map(&:to_i).sum }

puts calories_by_reindeer.max

puts calories_by_reindeer.sort
                         .reverse
                         .first(3)
                         .sum
