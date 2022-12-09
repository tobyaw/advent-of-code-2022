#!/usr/bin/env ruby

MOVES = { 'D' => [0, -1], 'U' => [0, 1], 'L' => [-1, 0], 'R' => [1, 0] }

input = File.readlines('day_09_input.txt', chomp: true).map(&:split)

[2, 10].each do |length|
  coords = (1..length).map { { x: 0, y: 0 } }
  positions = [coords.first.values]

  input.each do |direction, distance|
    distance.to_i.times do
      coords.first[:x] += MOVES[direction][0]
      coords.first[:y] += MOVES[direction][1]

      coords.each_cons(2) do |i, j|
        if (i[:x] - j[:x]).abs > 1 && (i[:y] - j[:y]).abs > 1
          j[:x] = i[:x] + (j[:x] > i[:x] ? 1 : -1)
          j[:y] = i[:y] + (j[:y] > i[:y] ? 1 : -1)
        elsif (i[:y].eql? j[:y]) && (i[:x] - j[:x]).abs > 1
          j[:x] = i[:x] + (j[:x] > i[:x] ? 1 : -1)
        elsif (i[:x].eql? j[:x]) && (i[:y] - j[:y]).abs > 1
          j[:y] = i[:y] + (j[:y] > i[:y] ? 1 : -1)
        elsif (i[:x] - j[:x]).abs > 1
          j[:x] = i[:x] + (j[:x] > i[:x] ? 1 : -1)
          j[:y] = i[:y]
        elsif (i[:y] - j[:y]).abs > 1
          j[:x] = i[:x]
          j[:y] = i[:y] + (j[:y] > i[:y] ? 1 : -1)
        end
      end

      positions.push coords.last.values
    end
  end

  puts positions.uniq.count
end
