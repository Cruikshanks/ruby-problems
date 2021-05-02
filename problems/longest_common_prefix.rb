# frozen_string_literal: true

# Problem: Write a function to find the longest common prefix string amongst an array of strings.
#
# If there is no common prefix, return an empty string "".

# @param {String[]} strs
# @return {String}
# Result on leetcode was that this first attempt was slower than 95% of submissions. Ouch!
# 244ms
def longest_common_prefix(strs)
  return '' if strs.empty?

  matches = []
  shortest_word = strs.min_by(&:length)
  shortest_word.chars.each { |char| matches.push([char, true]) }

  strs.each do |word|
    matches.each_with_index do |match, idx|
      unless match[0] == word.chars[idx]
        match[1] = false
        break
      end
    end
  end

  prefix = []
  matches.each do |match|
    break unless match[1]

    prefix.push(match[0])
  end

  prefix.join
end

# Result on leetcode was that this attempt was slower than 74% of submissions.
# 72ms
def longest_common_prefix_horizontal_scan(strs)
  return '' if strs.empty?

  prefix = strs[0]
  strs.each do |word|
    until word.start_with?(prefix)
      prefix = prefix[0, prefix.length - 1]

      break if prefix == ''
    end
  end

  prefix
end

tests = [
  { input: %w[flower flow flight], output: 'fl' },
  { input: %w[flowing flow flight], output: 'fl' },
  { input: %w[dog racecar car], output: '' },
  { input: %w[aa aa], output: 'aa' }
]

puts 'First attempt'
tests.each do |test|
  result = longest_common_prefix(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end

puts 'Horizontal scan'
tests.each do |test|
  result = longest_common_prefix_horizontal_scan(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end
