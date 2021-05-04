# frozen_string_literal: true

# Problem: Given a sorted array nums, remove the duplicates in-place such that each element appears only once and
# returns the new length.
#
# Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra
# memory.
#
# Clarification:
#
# Confused why the returned value is an integer but your answer is an array?
#
# Note that the input array is passed in by reference, which means a modification to the input array will be known to
# the caller as well.
#
# Internally you can think of this:
#
# ```
# // nums is passed in by reference. (i.e., without making a copy)
# int len = removeDuplicates(nums);
#
# // any modification to nums in your function would be known by the caller.
# // using the length returned by your function, it prints the first len elements.
# for (int i = 0; i < len; i++) {
#     print(nums[i]);
# }
# ```
#
# Example 1:
#
# Input: nums = [1,1,2]
# Output: 2, nums = [1,2]
# Explanation: Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.
# It doesn't matter what you leave beyond the returned length.
#
# Example 2:
#
# Input: nums = [0,0,1,1,1,2,2,3,3,4]
# Output: 5, nums = [0,1,2,3,4]
# Explanation: Your function should return length = 5, with the first five elements of nums being modified to 0, 1, 2,
# 3, and 4 respectively. It doesn't matter what values are set beyond the returned length.
#
# Notes - I made the same mistake as a number of other folks with this problem. I focused on trying to actually remove
# the duplicate elements in the array in my rush to a solution. Re-reading the description and examples it does show
# that all that was expected was that the non-duplicate values would be written to the start of the array. It's not even
# a case of switching values. This is why if the input array is [0,0,1,1,1,2,2,3,3,4] the array actually looks like this
# [0, 1, 2, 3, 4, 2, 2, 3, 3, 4] after passing through the method.

# The leetcode solution converted to ruby
# Runtime: 64 ms, faster than 74.45% of Ruby online submissions for Remove Duplicates from Sorted Array.
# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums)
  return 0 if nums.empty?

  slow_idx = 0
  nums.each do |num|
    if num != nums[slow_idx]
      slow_idx += 1
      nums[slow_idx] = num
    end
  end

  slow_idx + 1
end

tests = [
  { input: [1, 1, 2], output: 2, check: [1, 2, 2] },
  { input: [0, 0, 1, 1, 1, 2, 2, 3, 3, 4], output: 5, check: [0, 1, 2, 3, 4, 2, 2, 3, 3, 4] },
  { input: [1, 2], output: 2, check: [1, 2] },
  { input: [1, 1, 1], output: 1, check: [1, 1, 1] }
]

puts 'Ruby version of solution'
tests.each do |test|
  result = remove_duplicates(test[:input])
  puts("Test result #{result} - #{result == test[:output]} - #{test[:input] == test[:check]}")
end

# For reference these solutions actually remove elements. By looking at the object_id of the arrays though you can see
# they all generate a new array which breaks the constraint of the test. Also, it makes the same initial
# misunderstanding about what is required I made.
# Credit to https://leetcode.com/user9051V/
# https://leetcode.com/problems/remove-duplicates-from-sorted-array/discuss/426902/Easy-ruby-solution
def remove_duplicates_ruby_remove(nums)
  nums.uniq!
  nums.length
end

# Credit to https://leetcode.com/vicentedpsantos/
# https://leetcode.com/problems/remove-duplicates-from-sorted-array/discuss/279799/Ruby
def remove_duplicates_remove(nums)
  return if nums.empty?

  nums.length.times { |i| nums[i] = nil if nums[i] == nums[i + 1] }
  nums.delete(nil)

  nums.length
end
