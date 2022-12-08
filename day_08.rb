#!/usr/bin/env ruby

def process(row)
  row.reduce([-1]) do |memo, cell|
    cell[:visible] = true if cell[:height] > memo.max
    cell[:scores] << ((memo.index { |i| i >= cell[:height] } || (memo.size - 2)) + 1)
    [cell[:height]] + memo
  end
end

input = File.readlines('day_08_input.txt', chomp: true)
            .map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }

[input, input.transpose].each { |i| i.each { |j| [j, j.reverse].each { |k| process k } } }

puts input.flatten.select { |i| i[:visible].eql? true }.count
puts input.flatten.map { |i| i[:scores].reduce(:*) }.max
