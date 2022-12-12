#!/usr/bin/env ruby

def find_char(grid, item)
  y = grid.find_index { |i| i.include? item }
  x = grid[y].index(item)

  [x, y]
end

def find_target(grid, heads, target, depth = 1)
  outputs = []

  heads.each do |xh, yh|
    grid[yh][xh][:seen] = true

    directions = [[xh, yh + 1], [xh, yh - 1], [xh + 1, yh], [xh - 1, yh]]
                 .reject { |x, y| x.negative? || y.negative? }
                 .filter { |x, y| (x < grid.first.size) && (y < grid.size) }
                 .reject { |x, y| grid[y][x][:seen].eql? true }
                 .filter { |x, y| grid[y][x][:height] - grid[yh][xh][:height] < 2 }

    raise depth.to_s if directions.map { |x, y| grid[y][x][:char] }.include? target

    directions.each { |i| outputs << i }
  end

  raise 'no options' if outputs.empty?

  find_target(grid, outputs.uniq, target, depth + 1)
end

input = File.readlines('day_12_input.txt', chomp: true)

[
  { start: 'S', target: 'E', tr: 'az', atoz: 'a-z' },
  { start: 'E', target: 'z', tr: 'za', atoz: ('a'..'z').to_a.join.reverse }
].each do |part|
  grid = input.map do |row|
    row.tr('a-z', part[:atoz])
       .chars
       .map do |char|
      { char:, height: char.tr('SE', part[:tr]).ord, seen: false }
    end
  end

  find_target(grid, [find_char(input, part[:start])], part[:target])
rescue StandardError => e
  puts e.message
end
