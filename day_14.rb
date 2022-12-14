#!/usr/bin/env ruby

input = File.readlines('day_14_input.txt', chomp: true)
            .map { |i| i.split(' -> ') }

[false, true].each do |floor|
  x_min, x_max = input.flatten.map(&:to_i).minmax
  y_max = input.flatten.map { |i| i.sub(/\d+,/, '').to_i }.max

  if floor
    y_max += 2
    x_min -= y_max
    x_max += y_max
    input << [x_min, x_max].map { |i| "#{i},#{y_max}" }
  end

  grid = x_min.upto(x_max)
              .to_h { |i| [i, ['.'] * (y_max + 1)] }

  input.each do |i|
    i.map { |j| j.split(',').map(&:to_i) }
     .each_cons(2) do |j, k|
      xs = [j, k].map(&:first).sort
      ys = [j, k].map(&:last).sort

      (xs[0]..xs[1]).each do |x|
        (ys[0]..ys[1]).each do |y|
          grid[x][y] = '#'
        end
      end
    end
  end

  (0..).each do |i|
    x = 500
    y = 0
    raise i.to_s unless grid[x][y].eql? '.'

    loop do
      moves = [x, x - 1, x + 1].map { |j| [j, y + 1] }
      moves.each do |j, k|
        raise i.to_s unless (x_min..x_max).include?(j) && (0..y_max).include?(k)
      end

      move = moves.filter { |j, k| grid[j][k].eql?('.') }.first
      break if move.nil?

      x, y = move
    end

    grid[x][y] = 'o'
  end
rescue StandardError => e
  puts e.message
end
