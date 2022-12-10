#!/usr/bin/env ruby

history = []

File.readlines('day_10_input.txt', chomp: true).map(&:split)
    .each.with_object({ c: 0, x: 1 }) do |line, state|
  case line
  in ['noop']
    state[:c] += 1
  in ['addx', i]
    state[:c] += 2
    state[:x] += i.to_i
  end

  history.push state.dup
end

# 14520
puts 20.step(by: 40, to: 220).map { |c| c * history.select { |i| i[:c] < c }.last[:x] }.sum
