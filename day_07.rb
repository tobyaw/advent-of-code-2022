#!/usr/bin/env ruby

input = File.readlines('day_07_input.txt', chomp: true)
            .map(&:split)

folders = Hash.new(0)
current_folder = []

input.each do |line|
  case line
  in ['$', 'cd', '..']
    current_folder.pop
  in ['$', 'cd', folder]
    current_folder.push folder
  in [size, file]
    path = []
    current_folder.each do |folder|
      path.push folder
      folders[path.join '/'] += size.to_i
    end
  else
  end
end

puts folders.values.reject { |i| i > 100_000 }.sum
puts folders.values.reject { |i| i < folders['/'] - 40_000_000 }.min
