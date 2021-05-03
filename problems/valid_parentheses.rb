# frozen_string_literal: true

# Problem: Given a string `s` containing just the characters (, ), {, }, [ and ], determine if the input string is
# valid.
#
# An input string is valid if:
# - Open brackets must be closed by the same type of brackets.
# - Open brackets must be closed in the correct order.

# @param {String} s
# @return {Boolean}
# Runtime: 56 ms, faster than 64.91% of Ruby online submissions for Valid Parentheses.
# Memory Usage: 210 MB, less than 65.84% of Ruby online submissions for Valid Parentheses.
def is_valid(s)
  return false if s.chars.empty?
  return false if [')', ']', '}'].include?(s.chars.first)

  brackets = {
    ')' => '(',
    ']' => '[',
    '}' => '{'
  }
  open_brackets = ['(', '[', '{']
  queue = []

  s.chars.each do |char|
    if open_brackets.include?(char)
      queue.push(char)
      next
    end

    opening_bracket = brackets[char]
    return false unless queue.last == opening_bracket

    queue.pop if queue.last == opening_bracket
  end

  queue.empty?
end

# Found when checking the details of my results. Hat's off, this is a lovely, clean solution. Think I focused to much on
# trying to avoid using a case when it's clearly a great solution for this. No source though so I can't credit anyone.
def is_valid_fast(s)
  return true if s.empty?

  stack = []
  s.each_char do |c|
    case c
    when '(', '{', '['
      stack.push(c)
    when ')'
      return false if stack.pop != '('
    when '}'
      return false if stack.pop != '{'
    when ']'
      return false if stack.pop != '['
    end
  end
  stack.empty?
end

tests = [
  { input: '()', output: true },
  { input: '()[]{}', output: true },
  { input: '(]', output: false },
  { input: '([)]', output: false },
  { input: '{[]}', output: true },
  { input: ']', output: false },
  { input: '', output: false },
  { input: '(])', output: false }
]

puts 'My attempt'
tests.each do |test|
  result = is_valid(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end

puts 'Fast solution'
tests.each do |test|
  result = is_valid_fast(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end
