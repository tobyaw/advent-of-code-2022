#!/usr/bin/env ruby

folder_sizes = Hash.new(0)

File.readlines('day_07_input.txt', chomp: true).map(&:split).each_with_object([]) do |line, stack|
  case line
  in ['$', 'cd', '..']
    stack.pop
  in ['$', 'cd', folder]
    stack.push folder
  in [size, file] if size.match?(/^\d+$/)
    stack.reduce('') { |j, i| folder_sizes[j += i] += size.to_i; j }
  else
  end
end

puts folder_sizes.values.reject { |i| i > 100_000 }.sum
puts folder_sizes.values.reject { |i| i < folder_sizes['/'] - 40_000_000 }.min
