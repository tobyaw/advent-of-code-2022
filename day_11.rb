#!/usr/bin/env ruby

[{ rounds: 20, div: 3 }, { rounds: 10_000, div: 1 }].each do |part|
  monkies = File.read('day_11_input.txt').split("\n\n").map do |i|
    i = i.split("\n")

    {
      items: i[1].scan(/\d+/).map(&:to_i),
      oper: i[2].scan(/[+*]/).first.to_sym,
      param: i[2].scan(/\d+$/).map(&:to_i).first,
      test: i[3].scan(/\d+$/).first.to_i,
      pass: i[4].scan(/\d+$/).first.to_i,
      fail: i[5].scan(/\d+$/).first.to_i,
      inspections: 0
    }
  end

  lcm = monkies.map { |i| i[:test] }.reduce(:lcm)

  part[:rounds].times.each do
    monkies.each do |monkey|
      monkey[:inspections] += monkey[:items].size

      while (i = monkey[:items].shift)
        param = monkey[:param] || i
        i = (i.method(monkey[:oper]).call(param) / part[:div]) % lcm

        target = (i % monkey[:test]).zero? ? monkey[:pass] : monkey[:fail]
        monkies[target][:items] << i
      end
    end
  end

  puts monkies.map { |i| i[:inspections] }.max(2).reduce(:*)
end
