# frozen_string_literal: true

# Problem: Implement [strStr()](http://www.cplusplus.com/reference/cstring/strstr/).
#
# Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
#
# Clarification:
#
# What should we return when needle is an empty string? This is a great question to ask during an interview.
#
# For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's
# [strStr()](http://www.cplusplus.com/reference/cstring/strstr/) and Java's
# [indexOf()](https://docs.oracle.com/javase/7/docs/api/java/lang/String.html#indexOf(java.lang.String)).

# @param {String} haystack
# @param {String} needle
# @return {Integer}
def str_str_to_slow(haystack, needle)
  return 0 if needle == ''
  return 0 if needle == haystack
  return -1 if needle.length > haystack.length

  max = haystack.length - 1

  (0..max).each do |h_idx|
    matched = true
    needle.chars.each_with_index do |n_char, n_idx|
      if n_char != haystack[h_idx + n_idx]
        matched = false
        break
      end
    end
    return h_idx if matched
  end
  -1
end

# Runtime: 56 ms, faster than 65.29% of Ruby online submissions for Implement strStr().
def str_str_ruby(haystack, needle)
  return 0 if needle == ''

  idx = haystack.index(needle)

  return -1 unless idx

  idx
end

# Great thinking to reduce cycles and simplify the problem
#
# Work out the difference between the haystack and the needle and you work out how many times you need to test for the
# needle. For example, 'hello - ll + 1 == 5 - 2 + 1 == 4'. What we are then looking to test is
#
# he - el - ll - lo
#
# Having worked out how many times to attempt the test the next section extracts the current 'part' from the haystack
# and compares it to the string, for example
#
# haystack[0..1] == 'll' is the same as 'he' == 'll'
#
# Credit: https://leetcode.com/piyushsawaria/
# https://leetcode.com/problems/implement-strstr/discuss/814319/Ruby-simple-solution
# Runtime: 44 ms, faster than 97.52% of Ruby online submissions for Implement strStr().
def str_str_alternate(haystack, needle)
  return 0 if needle == ''
  return -1 if needle.length > haystack.length

  puts("Times #{haystack.length - needle.length + 1}")
  (haystack.length - needle.length + 1).times do |idx|
    top = idx + needle.length - 1
    return idx if haystack[idx..top] == needle
  end

  -1
end

tests = [
  { haystack: 'hello', needle: 'll', output: 2 },
  { haystack: 'aaaaa', needle: 'bba', output: -1 },
  { haystack: '', needle: '', output: 0 }
]

# puts('Using the too slow method')
# tests.each do |test|
#   result = str_str_to_slow(test[:haystack], test[:needle])
#   puts("Test result #{result} - #{result == test[:output]}")
# end

# puts('Using ruby magic')
# tests.each do |test|
#   result = str_str_ruby(test[:haystack], test[:needle])
#   puts("Test result #{result} - #{result == test[:output]}")
# end

puts('Using posted alternate')
tests.each do |test|
  result = str_str_alternate(test[:haystack], test[:needle])
  puts("Test result #{result} - #{result == test[:output]}")
end
