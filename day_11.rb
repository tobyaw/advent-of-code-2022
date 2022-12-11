#!/usr/bin/env ruby

[{ rounds: 20, div: 3 }, { rounds: 10_000, div: 1 }].each do |part|
  monkies = File.read('day_11_input.txt').split("\n\n")
                .map { |i| i.split("\n") }
                .map do |i|
    m = i[2].match(/new = old (.) (.+)$/)

    {
      items: i[1].match(/: (.+)$/)[1].split(', ').map(&:to_i),
      oper: m[1].to_sym,
      param: m[2].match?(/^\d+$/) ? m[2].to_i : m[2].to_sym,
      test: i[3].split.last.to_i,
      pass: i[4].split.last.to_i,
      fail: i[5].split.last.to_i,
      inspections: 0
    }
  end

  mod = monkies.map { |i| i[:test] }.reduce(:*)

  part[:rounds].times.each do
    monkies.each do |i|
      i[:inspections] += i[:items].size

      while (j = i[:items].shift)
        param = i[:param].eql?(:old) ? j : i[:param]
        j = (j.method(i[:oper]).call(param) / part[:div]) % mod
        monkies[(j % i[:test]).zero? ? i[:pass] : i[:fail]][:items].push j
      end
    end
  end

  puts monkies.map { |i| i[:inspections] }.max(2).reduce(:*)
end
