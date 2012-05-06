# Challenge 10:  Coding m00re and m00re - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge10.rb

def evaluate(input)
  stack=[]
  stack.push input.shift.to_i

  input.each do |p|
    case p
      when "mirror"
        stack.push -stack.pop
      when "breadandfish"
        stack.push stack.last
      when "fire"
        stack.push stack.pop(2).max
      when "dance"
        stack += stack.pop(2).reverse
      when "conquer"
        stack.push stack.pop(2).inject(:%)
      when "@"
        stack.push stack.pop + stack.pop
      when "$"
        stack.push -stack.pop + stack.pop
      when "#"
        stack.push stack.pop * stack.pop
      when "&"
        stack.push stack.pop(2).inject(:/)
      when "."
        puts stack.pop
      else
        stack.push p.to_i
    end
  end
end

STDIN.each_line do |input|
  evaluate input.strip.split
end
