#!/usr/bin/env ruby

table, steps = File.read('day_05_input.txt')
                   .split(/\n\n/)
                   .map { |i| i.split(/\n/) }

keys = table.pop
            .scan(/\d/)

values = table.map(&:chars)
              .transpose
              .select.with_index { |_, i| (i % 4).eql? 1 }
              .map(&:reverse)
              .each { |i| i.delete(' ') }

stacks = (1..2).map { keys.zip(values.map(&:dup)).to_h }

steps.map { |i| i.scan(/\d+/) }
     .each do |num, source, target|
  stacks.first[target].concat stacks.first[source].pop(num.to_i).reverse
  stacks.last[target].concat stacks.last[source].pop(num.to_i)
end

stacks.each { |i| puts i.values.map(&:last).join }
