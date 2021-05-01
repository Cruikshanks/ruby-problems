# frozen_string_literal: true

# Problem: Given an integer x, return true if x is palindrome integer. An integer is a palindrome when it reads the same
# backward as forward. For example, 121 is palindrome while 123 is not.
#
# Note to self; was able to see that converting it to a string, then reversing and comparing the values would solve the
# problem. But the follow up asked if it could be solved without string conversion. Initially, I went with a tweaked
# version of the 'reverse integer' solution. But reviewing the actual solution it highlighted that you don't need to
# reverse the whole number before testing for a palindrome. If you can reverse the last half of the number, and compare
# that to the first half, you confirm if it's palindrome.

# @param {Integer} x
# @return {Boolean}
def is_palindrome_string(x)
  return x.to_s == x.to_s.reverse
end

def is_palindrome(x)
  # -121 when read backward is 121-. So, any negative number is not a palindrome
  return false if x < 0
  # Another edge case. If the last digit of x is 0 then in order to be a palindrome the first digit of x must also be a
  # 0, which of course it won't be for a number!
  return false if x % 10 == 0 && x != 0

  # We can only return a result if its in the integer range cited (-2 to power of 31 to 2 to power of 31 -1). So, first
  # we determine what those values are (note - ** is Ruby's operator for exponentiation)
  max = 2 ** 31 -1
  min = -2 ** 31

  rev = 0
  count = 1
  while x > rev
    count += 1
    # To 'pop' the last digit off we use modulo % which returns the remainder of a division. If we divide by 10 we get
    # the ones column as the remainder. Assuming x is 121 the result would be 1
    pop = x % 10

    # Having gotten the last digit, we now want to 'drop' the last digit from x and make it 12. We do this by making it
    # the result of x / 10. As both sides are integers ruby will return an integer which in this case is 12
    x /= 10

    # Do our checks to ensure we don't overflow the integer range set in the problem
    return 0 if rev > max / 10 || (rev == max / 10 && pop > 7)
    return 0 if rev < min / 10 || (rev == min / 10 && pop < -8)

    # Finally we 'push' the last digit onto our new number. On the first pass we'd have 0 * 10 + 1 = 1. On the second it would
    # be 1 * 10 + 2 = 12. We skip the last one because now x = 1 and rev = 12
    rev = rev * 10 + pop
  end

  # This takes into account odd length numbers like 121. So, at this point x == 1 and rev == 12. But forwards or
  # backwards in an odd number we know the middle one will always be the same (2 in this case). So, we 'get rid' of the
  # 2 by dividing rev by 10 which leaves 1 (because in ruby integer division always results in an integer result).
  # This the translates as (false || true) == true
  return x == rev || x == rev / 10
end

tests = [
  { input: 121, output: true },
  # { input: -121, output: false },
  # { input: 10, output: false },
  # { input: -101, output: false },
  # { input: 1234567899, output: false }
]

puts 'Reverse string version'
tests.each do |test|
  result = is_palindrome_string(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end

puts 'Using pure math'
tests.each do |test|
  result = is_palindrome(test[:input])
  puts("Test result #{result} - #{result == test[:output]}")
end
