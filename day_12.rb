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

  puts "depth #{depth} with #{heads.count} heads"
  heads.each do |head|
    xl, yl = head
    xt, yt = target
    grid[yl][xl][:seen] = true
    height = grid[yl][xl][:height]

    grid_width = grid.first.size
    grid_height = grid.size

    directions = [[xl, yl + 1], [xl, yl - 1], [xl + 1, yl], [xl - 1, yl]]
                 .reject { |x, y| x.negative? || y.negative? || (x >= grid_width) || (y >= grid_height) }
                 .sort_by { |x, y| ((x - xt)**2) + ((y - yt)**2) }
                 .reject { |x, y| grid[y][x][:seen].eql? true }
                 .select { |x, y| grid[y][x][:height] - height < 2 }

    raise "done in #{depth}" if directions.include? target

    directions.each { |i| outputs << i }
  end

  raise 'no options' if outputs.empty?

  find_target(grid, outputs.uniq, target, depth + 1)
end

begin
  grid = input.map { |i| i.chars.map { |j| { char: j, height: j.tr('SE', 'az').ord, seen: false } } }
  find_target(grid, [find_char(input, 'S')], find_char(input, 'E'))
rescue StandardError => e
  puts e.message
end
