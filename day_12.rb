#!/usr/bin/env ruby

def find_next_steps(grid, heads, to, polarity, depth = 1)
  next_heads = []

  heads.each do |xh, yh|
    grid[yh][xh][:seen] = true

    steps = [[xh, yh + 1], [xh, yh - 1], [xh + 1, yh], [xh - 1, yh]]
            .reject { |x, y| x.negative? || y.negative? }
            .filter { |x, y| (x < grid.first.size) && (y < grid.size) }
            .reject { |x, y| grid[y][x][:seen].eql? true }
            .filter { |x, y| polarity * (grid[y][x][:h] - grid[yh][xh][:h]) < 2 }

    raise depth.to_s if steps.map { |x, y| grid[y][x][:char] }.include? to

    next_heads += steps
  end

  raise 'no options' if next_heads.empty?

  find_next_steps(grid, next_heads.uniq, to, polarity, depth + 1)
end

input = File.readlines('day_12_input.txt', chomp: true)

[
  { from: 'S', to: 'E', polarity: 1 },
  { from: 'E', to: 'a', polarity: -1 }
].each do |part|
  y = input.find_index { |i| i.include? part[:from] }
  x = input[y].index(part[:from])

  grid = input.map do |i|
    i.chars.map { |j| { char: j, h: j.tr('SE', 'az').ord, seen: false } }
  end

  find_next_steps(grid, [[x, y]], part[:to], part[:polarity])
rescue StandardError => e
  puts e.message
end
