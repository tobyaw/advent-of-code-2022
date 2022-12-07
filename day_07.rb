#!/usr/bin/env ruby

folders = Hash.new(0)

File.readlines('day_07_input.txt', chomp: true).map(&:split).each_with_object([]) do |line, stack|
  case line
  in ['$', 'cd', '..']
    stack.pop
  in ['$', 'cd', folder]
    stack.push [stack.last, folder].compact.join(' ')
  in [size, file] if size.match?(/^\d+$/)
    stack.each { |i| folders[i] += size.to_i }
  else
  end
end

puts folders.values.reject { |i| i > 100_000 }.sum
puts folders.values.reject { |i| i < folders['/'] - 40_000_000 }.min
