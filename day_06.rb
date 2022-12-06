#!/usr/bin/env ruby

[4, 14].each_with_object(File.read('day_06_input.txt').chars) do |length, chars|
  puts length + chars.each_cons(length).find_index { |arr| arr.eql? arr.uniq }
end
