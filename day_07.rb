#!/usr/bin/env ruby

folders = Hash.new(0)
current_folder = []
current_folder_stack = []

File.readlines('day_07_input.txt', chomp: true).map(&:split).each do |line|
  case line
  in ['$', 'cd', '..']
    current_folder.pop
    current_folder_stack.pop
  in ['$', 'cd', folder]
    current_folder.push folder
    current_folder_stack.push current_folder.join(' ')
  in [size, file] if size.match?(/^\d+$/)
    current_folder_stack.each { |i| folders[i] += size.to_i }
  else
  end
end

puts folders.values.reject { |i| i > 100_000 }.sum
puts folders.values.reject { |i| i < folders['/'] - 40_000_000 }.min
