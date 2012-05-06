# Challenge 2: The binary granny - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge02.rb

def hazelnuts(n)
  # n = (2^x - 1) + y
  # Example: 2135 = (2048-1) + 88 = 11111111111 + 1011000 (base 2) => 14 hazelnuts
  return 0 if n==0
  x=Math.log2(n).to_i # solve for x
  y=n-2**x+1 # solve for y
  y.to_s(2).scan("1").size + x # sum
end

readline.to_i.times do |x|
  printf "Case #%d: %d\n", x+1, hazelnuts(readline.to_i)
end
