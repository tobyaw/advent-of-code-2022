#!/usr/bin/env ruby

MOVES = { 'D' => [0, -1], 'U' => [0, 1], 'L' => [-1, 0], 'R' => [1, 0] }

input = File.readlines('day_09_input.txt', chomp: true).map(&:split)

[2, 10].each do |length|
  coords = (1..length).map { [0, 0] }
  positions = [coords.first.join('x')]

  input.each do |direction, distance|
    distance.to_i.times do
      coords[0] = coords[0].zip(MOVES[direction]).map { |i| i.reduce(:+) }

      coords.each_cons(2) do |i, j|
        if (i[0] - j[0]).abs > 1 && (i[1] - j[1]).abs > 1
          j[0] = i[0] + (j[0] > i[0] ? 1 : -1)
          j[1] = i[1] + (j[1] > i[1] ? 1 : -1)
        elsif (i[1].eql? j[1]) && (i[0] - j[0]).abs > 1
          j[0] = i[0] + (j[0] > i[0] ? 1 : -1)
        elsif (i[0].eql? j[0]) && (i[1] - j[1]).abs > 1
          j[1] = i[1] + (j[1] > i[1] ? 1 : -1)
        elsif (i[0] - j[0]).abs > 1
          j[0] = i[0] + (j[0] > i[0] ? 1 : -1)
          j[1] = i[1]
        elsif (i[1] - j[1]).abs > 1
          j[0] = i[0]
          j[1] = i[1] + (j[1] > i[1] ? 1 : -1)
        end
      end

      positions.push coords[-1].join('x')
    end
  end

  puts positions.uniq.count
end
