#!/usr/bin/env ruby

input = File.readlines('day_08_input.txt', chomp: true)
            .map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }

[input, input.transpose].each do |i|
  i.each do |j|
    [j, j.reverse].each do |k|
      highest = -1

      k.reduce([]) do |sum, l|
        if l[:height] > highest
          highest = l[:height]
          l[:visible] = true
        end

        l[:scores].push((sum.reverse.index { |m| m >= l[:height] } || (sum.size - 1)) + 1)
        sum + [l[:height]]
      end
    end
  end
end

puts input.flatten.select { |i| i[:visible].eql? true }.count
puts input.flatten.map { |i| i[:scores].reduce(:*) }.max
