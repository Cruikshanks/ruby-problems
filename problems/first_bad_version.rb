# frozen_string_literal: true

# Problem: First Bad Version
#
# You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of
# your product fails the quality check. Since each version is developed based on the previous version, all the versions
# after a bad version are also bad.
#
# Suppose you have `n` versions `[1, 2, ..., n]` and you want to find out the first bad one, which causes all the
# following ones to be bad.
#
# You are given an API `bool isBadVersion(version)` which returns whether version is bad. Implement a function to find
# the first bad version. You should minimize the number of calls to the API.
#
# Example 1
# Input: n = 5, bad = 4
# Output: 4
# Explanation:
#   call isBadVersion(3) -> false
#   call isBadVersion(5) -> true
#   call isBadVersion(4) -> true
# Then 4 is the first bad version.
#
# Example 2
# Input: n = 1, bad = 1
# Output: 1
# Explanation:
#   call isBadVersion(1) -> true
# Then 1 is the first bad version.

# We need to implement our own version of is_bad_version to mirror what leetcode does
# The is_bad_version API is already defined for you.
# @param {Integer} version
# @return {boolean} whether the version is bad
@bad_version = 0
def is_bad_version(version)
  return true if version >= @bad_version

  false
end

# @param {Integer} n
# @return {Integer}
# Runtime: 56 ms, faster than 28.18% of Ruby online submissions for First Bad Version.
def first_bad_version(n)
  left = 1
  right = n

  while left <= right
    mid = left + ((right - left) / 2)
    puts("MID #{mid} LEFT #{left} RIGHT #{right}")

    if is_bad_version(mid)
      right = mid - 1
    else
      left = mid + 1
    end
  end
  left
end

# Implementation of leetcode solution. Only difference is while condition is just `left < right` (no equals) and if
# `is_bad_version()` is true then we set `right = mid` rather than `right = mid - 1`. Performance is exactly the same
# however.
# Runtime: 56 ms, faster than 28.18% of Ruby online submissions for First Bad Version.
def first_bad_version_leetcode(n)
  left = 1
  right = n

  while left < right
    mid = left + ((right - left) / 2)
    puts("MID #{mid} LEFT #{left} RIGHT #{right}")

    if is_bad_version(mid)
      right = mid
    else
      left = mid + 1
    end
  end
  left
end

# Credit: https://leetcode.com/StefanPochmann/
# https://leetcode.com/problems/first-bad-version/discuss/71333/1-liner-in-Ruby-Python
# Runtime: 44 ms, faster than 89.09% of Ruby online submissions for First Bad Version.
def first_bad_version_one_liner(n)
  (1..n).bsearch(&method(:is_bad_version))
end

tests = [
  { input: 5, output: 4 },
  { input: 1, output: 1 }
]

puts 'Initial attempt'
tests.each do |test|
  @bad_version = test[:output]
  result = first_bad_version(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end

puts 'Leetcode solution'
tests.each do |test|
  @bad_version = test[:output]
  result = first_bad_version_leetcode(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end

puts 'One liner solution'
tests.each do |test|
  @bad_version = test[:output]
  result = first_bad_version_leetcode(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end
