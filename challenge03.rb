# Challenge 3: The evil trader - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge03.rb

t=tmin=gain=tbuy=tsell=0
minstock=nil

STDIN.each_line do |line|
  stock=line.to_i
  if minstock.nil? || stock<minstock
    minstock=stock
    tmin=t
  elsif stock-minstock > gain
    gain=stock-minstock
    tbuy=tmin
    tsell=t
  end    
  t+=100
end

printf "%d %d %d\n", tbuy, tsell, gain
