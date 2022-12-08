#!/usr/bin/env ruby

input = File.readlines('day_08_input.txt', chomp: true)
            .map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }

[input, input.transpose].each do |i|
  i.each do |j|
    [j, j.reverse].each do |k|
      highest = -1
      heights_so_far = []

      k.each do |l|
        if l[:height] > highest
          highest = l[:height]
          l[:visible] = true
        end

        visible = 0
        heights_so_far.reverse.each do |item|
          visible += 1
          break if item >= l[:height]
        end

        l[:scores].push visible
        heights_so_far.push l[:height]
      end
    end
  end
end

puts input.flatten.select { |i| i[:visible].eql? true }.count
puts input.flatten.map { |i| i[:scores].reduce(:*) }.max
