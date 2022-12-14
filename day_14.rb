#!/usr/bin/env ruby

input = File.readlines('day_14_input.txt', chomp: true).map { |i| i.split(' -> ') }

[false, true].each do |floor|
  x_min, x_max = input.flatten.map(&:to_i).minmax
  y_max = input.flatten.map { |i| i.sub(/^\d+,/, '').to_i }.max

  if floor
    y_max += 2
    x_min -= y_max
    x_max += y_max
    input << [x_min, x_max].map { |i| "#{i},#{y_max}" }
  end

  grid = (x_min..x_max).to_h { |i| [i, ['.'] * (y_max + 1)] }

  input.each do |i|
    i.map { |j| j.split(',').map(&:to_i) }.each_cons(2) do |j, k|
      Range.new(*[j, k].map(&:first).sort).each do |x|
        Range.new(*[j, k].map(&:last).sort).each do |y|
          grid[x][y] = '#'
        end
      end
    end
  end

  (0..).each_with_object([500, 0]) do |i, (x, y)|
    raise i.to_s unless grid[x][y].eql? '.'

    loop do
      moves = [0, -1, 1].map { |j| [x + j, y + 1] }.filter do |j, k|
        raise i.to_s unless (x_min..x_max).include?(j)
        raise i.to_s unless (0..y_max).include?(k)

        grid[j][k].eql? '.'
      end

      break if moves.empty?

      x, y = moves.first
    end

    grid[x][y] = 'o'
  end
rescue StandardError => e
  puts e.message
end
