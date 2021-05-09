# frozen_string_literal: true

# Problem: Search Insert Position
#
# Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return
# the index where it would be if it were inserted in order.
#
# You must write an algorithm with O(log n) runtime complexity.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
# First attempt but aware its an 0(n) solution
# Runtime: 44 ms, faster than 95.41% of Ruby online submissions for Search Insert Position.
def search_insert(nums, target)
  nums.each_with_index do |num, idx|
    return idx if num == target
    return idx if num > target
  end

  nums.length
end

# Calculating the mid point in a binary search is a 'known' formula. When first posited it was (L + R) / 2. However, in
# certain edge cases where the indices are fixed integers and large arrays are involved overflow errors are encountered.
# This is because (L+R) might exceed the size of an integer in the language being used. An alternative form was found
# and is now used https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
#
# L + ((R - L) / 2)
#
# In our tests below because nums is length 4, `mid` in each iteration starts out as 1
#
# 0 + ((3 - 0) / 2)
#
# Credit: https://leetcode.com/der/
# https://leetcode.com/problems/search-insert-position/discuss/15393/My-Ruby-Solution
# Runtime: 40 ms, faster than 98.17% of Ruby online submissions for Search Insert Position.
def search_insert_log(nums, target)
  left = 0
  right = nums.length - 1

  while left <= right
    mid = left + ((right - left) / 2)

    return mid if nums[mid] == target

    if target > nums[mid]
      left = mid + 1
    else
      right = mid - 1
    end
  end
  left
end

tests = [
  { nums: [1, 3, 5, 6], target: 5, output: 2 },
  { nums: [1, 3, 5, 6], target: 2, output: 1 },
  { nums: [1, 3, 5, 6], target: 7, output: 4 },
  { nums: [1, 3, 5, 6], target: 0, output: 0 },
  { nums: [1], target: 0, output: 0 }
]

puts('0(n) implementation')
tests.each do |test|
  result = search_insert(test[:nums], test[:target])
  puts("Test result #{result} - #{result == test[:output]}")
end

puts('0(log n) implementation')
tests.each do |test|
  result = search_insert_log(test[:nums], test[:target])
  puts("Test result #{result} - #{result == test[:output]}")
end
