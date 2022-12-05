#!/usr/bin/env ruby

table, steps = File.read('day_05_input.txt')
                   .split(/\n\n/)
                   .map { |i| i.split(/\n/) }

keys = table.pop
            .scan(/\d/)
            .map(&:to_i)

values = table.map(&:chars)
              .transpose
              .select.with_index { |_j, i| (i % 4).eql? 1 }
              .map(&:reverse)
              .each { |i| i.delete(' ') }

stacks = {
  a: keys.zip(values).to_h,
  b: keys.zip(values.map(&:dup)).to_h
}

steps.each do |step|
  num, source, target = step.scan(/\d+/)
                            .map(&:to_i)

  stacks[:a][target].concat stacks[:a][source].pop(num).reverse
  stacks[:b][target].concat stacks[:b][source].pop(num)
end

stacks.each_value { |i| puts i.values.map(&:last).join }
