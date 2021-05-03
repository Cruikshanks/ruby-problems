# frozen_string_literal: true

# Problem: Merge two sorted linked lists and return it as a sorted list. The list should be made by splicing together
# the nodes of the first two lists.
#
# Example 1
# - l1 = [1, 2, 4]
# - l2 = [1, 3, 4]
# - expected result is [1, 1, 2, 3, 4, 4]
#
# Example 2
# - l1 = []
# - l2 = []
# - expected result is []
#
# Example 3
# - l1 = []
# - l2 = [0]
# - expected result is [0]
#
# Note - though Leetcode references the ListNode class the examples and expected results are all specified as arrays.
# So, my first attempt was actually merge_two_lists_arrays(). The proper solution is merge_two_lists() though this needs
# to be credited to
#
# - https://leetcode.com/kenhufford/
# - https://leetcode.com/problems/merge-two-sorted-lists/discuss/618937/Ruby-beats-80%2B-with-explanation-recursion
#
# By this point I'd figured out that recursion was key and had sorted the base checks but threw in the flag when it
# came to determining how to call merge_two_lists() recursively.

# Definition for singly-linked list.
# Instances of this are what Leetcode is passing in when run on the site for the l1 and l2 arguments to
# merge_two_lists()
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, next_node = nil)
    @val = val
    @next = next_node
  end
end

# Helper method to ensure to create deep clones of our test data. Without it merge_two_lists() will amend the linked
# node instance passed in which will effect subsequent tests.
def deep_copy(obj)
  Marshal.load(Marshal.dump(obj))
end

# Helper method to create our test linked lists
def create_linked_list(values)
  nodes = []

  previous_node = nil
  values.each do |num|
    previous_node = ListNode.new(num, previous_node)
    nodes.push(previous_node)
  end

  nodes.reverse
end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def merge_two_lists(l1, l2)
  return l2 unless l1
  return l1 unless l2
  return nil unless l1 && l2

  if l1.val < l2.val
    l1.next = merge_two_lists(l1.next, l2)
    l1
  else
    l2.next = merge_two_lists(l1, l2.next)
    l2
  end
end

n1 = create_linked_list([4, 2, 1])
n2 = create_linked_list([4, 3, 1])

tests = [
  { l1: deep_copy(n1.first), l2: deep_copy(n2.first), check: [1, 1, 2, 3, 4, 4] },
  { l1: nil, l2: nil, check: [] },
  { l1: nil, l2: deep_copy(n2.first), check: [1, 3, 4] }
]

puts 'Attempt using linked list array'
tests.each do |test|
  result = merge_two_lists(test[:l1], test[:l2])

  values = []
  next_node = result
  loop do
    break unless next_node

    values.push(next_node.val)
    next_node = next_node.next
  end
  puts("Test result #{result} - #{values == test[:check]}")
end

def merge_two_lists_arrays(l1, l2)
  return [] if l1.empty? && l2.empty?
  return l1 if l2.empty?
  return l2 if l1.empty?

  merged_list = []

  l1.each do |node1|
    if node1 < l2.first
      merged_list.push(node1)
      next
    end

    if node1 == l2.first
      merged_list.push(node1)
      merged_list.push(l2.shift)
      next
    end

    merged_list.push(l2.shift) while node1 > l2.first
  end
  merged_list.push(l1.last)
  merged_list.push(*l2)

  merged_list
end

tests = [
  { l1: [1, 2, 4], l2: [1, 3, 4], output: [1, 1, 2, 3, 4, 4] },
  { l1: [], l2: [], output: [] },
  { l1: [], l2: [0], output: [0] }
]

puts 'First attempt using standard arrays'
tests.each do |test|
  result = merge_two_lists_arrays(test[:l1], test[:l2])
  puts("Test result #{result} - #{result == test[:output]}")
end
