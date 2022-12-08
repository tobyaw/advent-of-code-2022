#!/usr/bin/env ruby

input = File.readlines('day_08_input.txt', chomp: true)
            .map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }

[input, input.transpose].each do |grid|
  grid.each do |grid_row|
    [grid_row, grid_row.reverse].each do |row|
      row.reduce([]) do |memo, cell|
        cell[:visible] = true if cell[:height] > (memo.max || -1)
        cell[:scores].push((memo.reverse.index { |i| i >= cell[:height] } || (memo.size - 1)) + 1)
        memo + [cell[:height]]
      end
    end
  end
end

puts input.flatten.select { |i| i[:visible].eql? true }.count
puts input.flatten.map { |i| i[:scores].reduce(:*) }.max
