#!/usr/bin/env ruby

def make_array(arr)
  arr = arr.split('-').map(&:to_i)
  Range.new(arr[0], arr[1]).to_a
end

input = File.read('day_04_input.txt').split("\n")
            .map { |i| i.split(',').map { |j| make_array(j) } }

puts input.filter { |i| i.include? i.inject(:&) }.count
puts input.filter { |i| i.inject(:&).count.positive? }.count
