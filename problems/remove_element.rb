# frozen_string_literal: true

# Problem: Given an array nums and a value val, remove all instances of that value in-place and return the new length.
#
# Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra
# memory.
#
# The order of elements can be changed. It doesn't matter what you leave beyond the new length.
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
# Input: nums = [3,2,2,3], val = 3
# Output: 2, nums = [2,2]
# Explanation: Your function should return length = 2, with the first two elements of nums being 2. It doesn't matter
# what you leave beyond the returned length. For example if you return 2 with nums = [2,2,3,3] or nums = [2,2,0,0], your
# answer will be accepted.
#
# Example 2:
#
# Input: nums = [0,1,2,2,3,0,4,2], val = 2
# Output: 5, nums = [0,1,4,0,3]
# Explanation: Your function should return length = 5, with the first five elements of nums containing 0, 1, 3, 0, and
# 4. Note that the order of those five elements can be arbitrary. It doesn't matter what values are set beyond the
# returned length.
#
# Output to help understand what is going on
#
# remove_element()
#
# Test 1 - input: [3, 2, 2, 3], val: 3
# (0) match=true  slow_idx=0 [3, 2, 2, 3]
# (1) match=false slow_idx=0 [3, 2, 2, 3]
# (2) match=false slow_idx=1 [2, 2, 2, 3]
# (3) match=true  slow_idx=2 [2, 2, 2, 3]
#
# Test 2 - input: [0, 1, 2, 2, 3, 0, 4, 2], val: 2
# (0) match=false slow_idx=0 [0, 1, 2, 2, 3, 0, 4, 2]
# (1) match=false slow_idx=1 [0, 1, 2, 2, 3, 0, 4, 2]
# (2) match=true  slow_idx=2 [0, 1, 2, 2, 3, 0, 4, 2]
# (3) match=true  slow_idx=2 [0, 1, 2, 2, 3, 0, 4, 2]
# (4) match=false slow_idx=2 [0, 1, 2, 2, 3, 0, 4, 2]
# (5) match=false slow_idx=3 [0, 1, 3, 2, 3, 0, 4, 2]
# (6) match=false slow_idx=4 [0, 1, 3, 0, 3, 0, 4, 2]
# (7) match=true  slow_idx=5 [0, 1, 3, 0, 4, 0, 4, 2]
#
# remove_element_pointers()
#
# Test 1 - input: [3, 2, 2, 3], val: 3
# (0) match=true  index=0 length=4 [3, 2, 2, 3]
# (1) match=true  index=0 length=3 [3, 2, 2, 3]
# (2) match=false index=0 length=2 [2, 2, 2, 3]
# (3) match=false index=1 length=2 [2, 2, 2, 3]
#
# Test 2 - input: [0, 1, 2, 2, 3, 0, 4, 2], val: 2
# (0) match=false index=0 length=8 [0, 1, 2, 2, 3, 0, 4, 2]
# (1) match=false index=1 length=8 [0, 1, 2, 2, 3, 0, 4, 2]
# (2) match=true  index=2 length=8 [0, 1, 2, 2, 3, 0, 4, 2]
# (3) match=true  index=2 length=7 [0, 1, 2, 2, 3, 0, 4, 2]
# (4) match=false index=2 length=6 [0, 1, 4, 2, 3, 0, 4, 2]
# (5) match=true  index=3 length=6 [0, 1, 4, 2, 3, 0, 4, 2]
# (6) match=false index=3 length=5 [0, 1, 4, 0, 3, 0, 4, 2]
# (7) match=false index=4 length=5 [0, 1, 4, 0, 3, 0, 4, 2]

# The leetcode solution converted to ruby
# Runtime: 44 ms, faster than 93.40% of Ruby online submissions for Remove Element.
# @param {Integer[]} nums
# @param {Integer} val
# @return {Integer}
def remove_element(nums, val)
  return 0 if nums.empty?

  slow_idx = 0
  nums.each do |num|
    if num != val
      nums[slow_idx] = num
      slow_idx += 1
    end
  end

  slow_idx
end

# Credit to https://leetcode.com/bricktsre/
# https://leetcode.com/problems/remove-element/discuss/310585/Ruby-Two-Pointer-Solution
def remove_element_pointers(nums, val)
  length = nums.length
  index = 0
  while index < length
    if nums[index] == val
      length -= 1
      nums[index] = nums[length]
    else
      index += 1
    end
  end
  length
end

tests = [
  { input: [3, 2, 2, 3], val: 3, output: 2, check: [2, 2] },
  { input: [0, 1, 2, 2, 3, 0, 4, 2], val: 2, output: 5, check: [0, 1, 3, 0, 4] }
]

puts 'Ruby version of solution'
tests.each do |test|
  result = remove_element(test[:input], test[:val])
  puts("Test result #{result} - #{test[:input].take(result)} - #{test[:input].take(result) == test[:check]}")
end

tests = [
  { input: [3, 2, 2, 3], val: 3, output: 2, check: [2, 2] },
  { input: [0, 1, 2, 2, 3, 0, 4, 2], val: 2, output: 5, check: [0, 1, 4, 0, 3] }
]

puts 'Using two pointers solution'
tests.each do |test|
  result = remove_element_pointers(test[:input], test[:val])
  puts("Test result #{result} - #{test[:input].take(result)} - #{test[:input].take(result) == test[:check]}")
end
