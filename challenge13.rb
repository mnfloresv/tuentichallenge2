# Challenge 13:  The crazy croupier - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge13.rb

def calc(n, l)
  
  # calc limits for each set
  if (l<=n/2)
    set1 = (1..l)
    remaining = (l+1..n-l)
    set2 = (n-l+1..n)
  else
    remaining = (1..2*l-n)
    set1 = (2*l-n+1..l)
    set2 = (l+1..n)
  end

  cycles = 1

  # for each card, calc its period
  (1..n).each do |i|
    count=0
    j=i

    while j!=i || count==0
      if set1.include? j
         j = 1+2*(l-j)
      elsif set2.include? j
         j = 2+2*(n-j)
      else
         j = n+remaining.first-j
      end
      count+=1
    end
    
    # and calc the smallest multiple of the period of this card with the previous
    cycles = cycles.lcm(count)
  end

  cycles
end

readline.to_i.times do |x|
  n, l = readline.split.map(&:to_i)
  printf "Case #%d: %d\n", x+1, calc(n, l)
end
