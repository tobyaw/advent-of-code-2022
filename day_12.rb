#!/usr/bin/env ruby

def find_next_steps(grid, heads, target, polarity, depth = 1)
  return if heads.empty?

  next_heads = []

  heads.each do |xh, yh|
    grid[yh][xh][:seen] = true

    steps = [[xh, yh + 1], [xh, yh - 1], [xh + 1, yh], [xh - 1, yh]]
            .reject { |x, y| x.negative? || y.negative? }
            .filter { |x, y| (x < grid.first.size) && (y < grid.size) }
            .reject { |x, y| grid[y][x][:seen].eql? true }
            .filter { |x, y| polarity * (grid[y][x][:h] - grid[yh][xh][:h]) < 2 }

    return depth if steps.map { |x, y| grid[y][x][:char] }.include? target

    next_heads += steps
  end

  find_next_steps(grid, next_heads.uniq, target, polarity, depth + 1)
end

input = File.readlines('day_12_input.txt', chomp: true)

[
  { from: 'S', target: 'E', polarity: 1 },
  { from: 'E', target: 'a', polarity: -1 }
].each do |part|
  y = input.find_index { |i| i.include? part[:from] }
  x = input[y].index(part[:from])

  grid = input.map do |i|
    i.chars.map { |j| { char: j, h: j.tr('SE', 'az').ord, seen: false } }
  end

  puts find_next_steps(grid, [[x, y]], part[:target], part[:polarity])
end
