# frozen_string_literal: true

# Problem: Given an array of integers nums and an integer target, return indices of the two numbers such that they add
# up to target.
#
# You may assume that each input would have exactly one solution, and you may not use the same element twice.
#
# You can return the answer in any order.

# The brute force approach is O(n2). This is because for each element in the array you may end up traversing the whole
# array again. The hash approach is O(n) because you only travers the array once.

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sums_brute(nums, target)
  # For each number in the array try adding it to all the other numbers. Return as soon as you find 2 that equal the
  # target
  nums.each_with_index do |num1, idx1|
    # nums[1..] will return the nums array minus the first element
    nums[1..].each_with_index do |num2, idx2|
      return [idx1, idx2 + 1] if (num1 + num2) == target
    end
  end
end

def two_sums_hash(nums, target)
  # Premised on the fact that if the target is 9, and the current num is 2, we would be looking for the position of 7
  # in the array (if it exists).
  checked = {}

  # If nums is [2, 7, 11, 15] and target is 9
  nums.each_with_index do |num, idx|
    # First, work out the difference, for example 9 - 2 = 7
    diff = target - num

    # If 7 is already in our hash return the idx we stored plus the current idx
    return [checked[diff], idx] if checked[diff]

    # Else using the current num as the key, store the current idx in the hash
    checked[num] = idx
  end
end

tests = [
  { nums: [2, 7, 11, 15], target: 9, output: [0, 1] },
  { nums: [3, 2, 4], target: 6, output: [1, 2] },
  { nums: [3, 3], target: 6, output: [0, 1] }
]

puts 'Brute force attempt'
tests.each do |test|
  result = two_sums_brute(test[:nums], test[:target])
  puts("Brute - Test result #{result} - #{result == test[:output]}")
end

puts 'Hash attempt'
tests.each do |test|
  result = two_sums_hash(test[:nums], test[:target])
  puts("Hash  - Test result #{result} - #{result == test[:output]}")
end
