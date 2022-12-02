#!/usr/bin/env ruby

strategy = File.read('day_02_input.txt').split("\n")

SCORES_A = {
  'A X' => 4,
  'A Y' => 8,
  'A Z' => 3,
  'B X' => 1,
  'B Y' => 5,
  'B Z' => 9,
  'C X' => 7,
  'C Y' => 2,
  'C Z' => 6
}.freeze

puts strategy.map { |i| SCORES_A[i] }.sum

SCORES_B = {
  'A X' => 3,
  'A Y' => 4,
  'A Z' => 8,
  'B X' => 1,
  'B Y' => 5,
  'B Z' => 9,
  'C X' => 2,
  'C Y' => 6,
  'C Z' => 7
}.freeze

puts strategy.map { |i| SCORES_B[i] }.sum
