# frozen_string_literal: true

# Problem: Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
#
# Symbol       Value
# I            1
# V            5
# X            10
# L            50
# C            100
# D            500
# M            1000
#
# For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply
# X + II. The number 27 is written as XXVII, which is XX + V + II.
#
# Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII.
# Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same
# principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:
#
# - I can be placed before V (5) and X (10) to make 4 and 9.
# - X can be placed before L (50) and C (100) to make 40 and 90.
# - C can be placed before D (500) and M (1000) to make 400 and 900.
#
#
# Given a roman numeral, convert it to an integer.

# @param {String} s
# @return {Integer}
def roman_to_int(s)
  numerals = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }

  numbers = []
  s.chars.reverse_each do |char|
    converted = numerals[char]
    if numbers.any? && numbers.last > converted
      numbers.push(converted * -1)
    else
      numbers.push(converted)
    end
  end

  numbers.inject(0, :+)
end

tests = [
  { input: 'III', output: 3 },
  { input: 'IV', output: 4 },
  { input: 'IX', output: 9 },
  { input: 'LVIII', output: 58 },
  { input: 'MCMXCIV', output: 1994 }
]

puts 'Initial attempt'
tests.each do |test|
  result = roman_to_int(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end
