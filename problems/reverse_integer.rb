# frozen_string_literal: true

# Problem: Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go
# outside the signed 32-bit integer range [-2(power 31), 2(power 31) - 1], then return 0.
#
# Note to self; oodles of solutions I found seemed to disregard the need to avoid an overflow by simply just using ruby
# string functions to reverse the number and then return it, or having reversed it then checking if the result was in
# the permitted range. I had to go hunting for solutions on this one. But I also have taken those and amended them to do
# the look ahead required to prevent an overflow

# @param {Integer} x
# @return {Integer}
def reverse(x)
  # We can only return a result if its in the integer range cited (-2 to power of 31 to 2 to power of 31 -1). So, first
  # we determine what those values are (note - ** is Ruby's operator for exponentiation)
  max = 2 ** 31 -1
  min = -2 ** 31

  # x needs to be a postive number for x % 10 to work (see below)
  neg = x.negative?
  x *= -1 if neg

  rev = 0
  while x != 0
    # To 'pop' the last digit off we use modulo % which returns the remainder of a division. If we divide by 10 we get
    # the ones column as the remainder. Assuming x is 123 the result would be 3. Note this only works if the number is
    # postive
    pop = x % 10

    # Having gotten the last digit, we now want to 'drop' the last digit from x and make it 12. We do this by making it
    # the result of x / 10. As both sides are integers ruby will return an integer which in this case is 12
    x /= 10

    # Do our checks to ensure we don't overflow the integer range set in the problem
    return 0 if rev > max / 10 || (rev == max / 10 && pop > 7)
    return 0 if rev < min / 10 || (rev == min / 10 && pop < -8)

    # Finally we 'push' the last digit onto our new number. On the first pass we'd have 0 * 10 + 3 = 3. On the second it would
    # be 3 * 10 + 2 = 32. On the last pass it would be 32 * 10 + 1 = 321
    rev = rev * 10 + pop
  end

  neg ? rev * -1 : rev
end

# Solution that uses the power of ruby. It does do the bit length check but again only after x_rev has been set to a
# value that would cause the overflow
# https://leetcode.com/problems/reverse-integer/discuss/267459/RUBY:-less100.00-Memory-Usage-5-Lines-of-Ruby-andand-(40-MS-greater-97-of-Submission)
def reverse_ruby(x)

  x_rev_signed = x > 0 ? '' : '-'
  x_rev = (x_rev_signed + x.to_s.split('-').last.reverse).to_i
  x_rev.bit_length > 31 ? 0 : x_rev
end

tests = [
  { input: 123, output: 321 },
  { input: -123, output: -321 },
  { input: 120, output: 21 },
  { input: 0, output: 0},
  { input: 617673396283947, output: 0}
]

puts 'Using pure math'
tests.each do |test|
  result = reverse(test[:input])
  puts("Test for #{test[:input]} - result #{result} - #{result == test[:output]}")
end

puts 'Using ruby features'
tests.each do |test|
  result = reverse_ruby(test[:input])
  puts("Test for #{test[:input]} - result #{result} - #{result == test[:output]}")
end
