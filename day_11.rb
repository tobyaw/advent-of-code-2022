#!/usr/bin/env ruby

[{ rounds: 20, divide: 3 }, { rounds: 10_000, divide: 1 }].each do |part|
  monkies = File.read('day_11_input.txt').split("\n\n")
                .map { |i| i.split("\n") }
                .map do |i|
    match = i[2].match(/new = old (.) (.+)$/)

    {
      items: i[1].match(/: (.+)$/)[1].split(', ').map(&:to_i),
      operation: match[1].to_sym,
      parameter: match[2].match?(/^\d+$/) ? match[2].to_i : match[2].to_sym,
      test: i[3].split.last.to_i,
      pass: i[4].split.last.to_i,
      fail: i[5].split.last.to_i,
      inspections: 0
    }
  end

  mod = monkies.map { |i| i[:test] }.reduce(:*)

  part[:rounds].times.each do
    monkies.each do |monkey|
      while (item = monkey[:items].shift)
        parameter = monkey[:parameter].eql?(:old) ? item : monkey[:parameter]
        item = (item.method(monkey[:operation]).call(parameter) / part[:divide]) % mod
        monkies[(item % monkey[:test]).zero? ? monkey[:pass] : monkey[:fail]][:items].push item
        monkey[:inspections] += 1
      end
    end
  end

  puts monkies.map { |i| i[:inspections] }.max(2).reduce(:*)
end

# 62491
# 17408399184
