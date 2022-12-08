#!/usr/bin/env ruby

input = File.readlines('day_08_input.txt', chomp: true)
            .map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }

[input, input.transpose].each do |grid|
  grid.each do |grid_row|
    [grid_row, grid_row.reverse].each do |row|
      highest = -1

      row.reduce([]) do |so_far, cell|
        if cell[:height] > highest
          highest = cell[:height]
          cell[:visible] = true
        end

        cell[:scores].push((so_far.reverse.index { |i| i >= cell[:height] } || (so_far.size - 1)) + 1)
        so_far + [cell[:height]]
      end
    end
  end
end

puts input.flatten.select { |i| i[:visible].eql? true }.count
puts input.flatten.map { |i| i[:scores].reduce(:*) }.max
