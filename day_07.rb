#!/usr/bin/env ruby

folders = Hash.new(0)
folder_stack = []

File.readlines('day_07_input.txt', chomp: true).map(&:split).each do |line|
  case line
  in ['$', 'cd', '..']
    folder_stack.pop
  in ['$', 'cd', folder]
    folder_stack.push [folder_stack.last, folder].compact.join(' ')
  in [size, file] if size.match?(/^\d+$/)
    folder_stack.each { |i| folders[i] += size.to_i }
  else
  end
end

puts folders.values.reject { |i| i > 100_000 }.sum
puts folders.values.reject { |i| i < folders['/'] - 40_000_000 }.min
