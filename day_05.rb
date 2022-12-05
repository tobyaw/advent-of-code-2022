#!/usr/bin/env ruby

require 'json'

table, steps = File.read('day_05_input.txt')
                   .split("\n\n")
                   .map { |i| i.split("\n") }

keys = table.pop
            .scan(/\d/)

values = table.map(&:chars)
              .transpose
              .each_slice(4)
              .map { |i| i[1].reverse.delete_if { |j| j.eql? ' ' } }

lookup_a = keys.zip(values).to_h
lookup_b = JSON.parse lookup_a.to_json # quick and dirty deep copy

steps.each do |step|
  num, source, target = step.scan(/\d+/)
  lookup_a[target].concat lookup_a[source].pop(num.to_i).reverse
  lookup_b[target].concat lookup_b[source].pop(num.to_i)
end

puts lookup_a.map { |_k, v| v.last }
             .join

puts lookup_b.map { |_k, v| v.last }
             .join
