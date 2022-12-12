#!/usr/bin/env ruby

filename = 'day_12_input.txt'
input = File.readlines(filename, chomp: true)

def find_char(grid, item)
  y = grid.find_index { |i| i.include? item }
  x = grid[y].index(item)

  [x, y]
end

def find_target(grid, heads, target, depth = 1)
  outputs = []

  heads.each do |head|
    xl, yl = head
    grid[yl][xl][:seen] = true
    height = grid[yl][xl][:height]

    grid_width = grid.first.size
    grid_height = grid.size

    directions = [[xl, yl + 1], [xl, yl - 1], [xl + 1, yl], [xl - 1, yl]]
                 .reject { |x, y| x.negative? || y.negative? || (x >= grid_width) || (y >= grid_height) }
                 .reject { |x, y| grid[y][x][:seen].eql? true }
                 .select { |x, y| grid[y][x][:height] - height < 2 }

    raise depth.to_s if directions.map { |x, y| grid[y][x][:char] }.include? target

    directions.each { |i| outputs << i }
  end

  raise 'no options' if outputs.empty?

  find_target(grid, outputs.uniq, target, depth + 1)
end

[
  { start: 'S', target: 'E', tr: 'az', atoz: 'a-z' },
  { start: 'E', target: 'z', tr: 'za', atoz: ('a'..'z').to_a.join.reverse }
].each do |part|
  grid = input.map { |i| i.tr('a-z', part[:atoz]).chars.map { |j| { char: j, height: j.tr('SE', part[:tr]).ord, seen: false } } }
  find_target(grid, [find_char(input, part[:start])], part[:target])
rescue StandardError => e
  puts e.message
end
