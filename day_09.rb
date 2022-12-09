#!/usr/bin/env ruby

MOVE = { 'D' => { x: 0, y: -1 }, 'U' => { x: 0, y: 1 }, 'L' => { x: -1, y: 0 }, 'R' => { x: 1, y: 0 } }

input = File.readlines('day_09_input.txt', chomp: true).map(&:split)

[2, 10].each do |length|
  coords = (1..length).map { { x: 0, y: 0 } }
  positions = [coords.first.values]

  input.each do |line|
    case line
    in [direction, distance] if distance.match?(/^\d+$/)
      distance.to_i.times do
        coords.first[:x] += MOVE[direction][:x]
        coords.first[:y] += MOVE[direction][:y]

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
  end

  puts positions.uniq.count
end