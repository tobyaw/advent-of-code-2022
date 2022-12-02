#!/usr/bin/env ruby

PLAYS = { 'A' => 1, 'B' => 2, 'C' => 3 }
WINS = { 'A' => 'C', 'B' => 'A', 'C' => 'B' }

strategy = File.read('day_02_input.txt').split("\n")

scores_a = strategy.sort.uniq.to_h do |key|
  (theirs, ours) = key.split
  ours.tr!('X-Z', 'A-C')

  score = PLAYS[ours]
  if WINS[ours].eql? theirs
    score += 6
  elsif ours.eql? theirs
    score += 3
  end

  [key, score]
end

scores_b = strategy.sort.uniq.to_h do |key|
  (theirs, outcome) = key.split

  score = case outcome
          when 'X' then 0 + PLAYS[WINS[theirs]]
          when 'Y' then 3 + PLAYS[theirs]
          when 'Z' then 6 + PLAYS[WINS.invert[theirs]]
          end

  [key, score]
end

puts strategy.map { |i| scores_a[i] }.sum
puts strategy.map { |i| scores_b[i] }.sum
