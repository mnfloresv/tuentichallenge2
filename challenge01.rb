# Challenge 1: The cell phone keypad - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge01.rb

# Times
T_HORIZ=300
T_VERT=200
T_DIAG=350
T_WAIT=500
T_PRESS=100

# Keypad as a Hash, character => [button, position]
KEYPAD = {" " => [1, 1], "1" => [1, 2],
          "A" => [2, 1], "B" => [2, 2], "C" => [2, 3], "2" => [2, 4],
          "D" => [3, 1], "E" => [3, 2], "F" => [3, 3], "3" => [3, 4],
          "G" => [4, 1], "H" => [4, 2], "I" => [4, 3], "4" => [4, 4],
          "J" => [5, 1], "K" => [5, 2], "L" => [5, 3], "5" => [5, 4],
          "M" => [6, 1], "N" => [6, 2], "O" => [6, 3], "6" => [6, 4],
          "P" => [7, 1], "Q" => [7, 2], "R" => [7, 3], "S" => [7, 4], "7" => [7, 5],
          "T" => [8, 1], "U" => [8, 2], "V" => [8, 3], "8" => [8, 4],
          "W" => [9, 1], "X" => [9, 2], "Y" => [9, 3], "Z" => [9, 4], "9" => [9, 5],
          "0" => [11, 1]}

# Returns the x and y positions of a button
def pos(n)
  [(n-1)%3, (n-1)/3]
end

# Calculates the time to move the finger from a to b
def dist(a, b)
  ax,ay=pos(a)
  bx,by=pos(b)
  dx=(ax-bx).abs
  dy=(ay-by).abs
  [dx, dy].min*T_DIAG + ( dx>dy ? (dx-dy)*T_VERT : (dy-dx)*T_HORIZ )
end

# Calculates the time to type a line
def cost_to_type(cad)
  prev="0"
  caps=false
  t=0
  cad.chars do |c|
    k1,_=KEYPAD[prev]
    k2,p2=KEYPAD[c.upcase]

    if caps && c=~/[a-z]/ || !caps && c=~/[A-Z]/ # caps lock
      t+=dist(k1, 12) + T_PRESS
      k1=12
      caps=!caps
    end

    t+= ( k1==k2  && t>0 ? T_WAIT : dist(k1, k2) ) + p2*T_PRESS
    prev=c.upcase
  end
  t
end

readline.strip.to_i.times do
  puts cost_to_type(readline.strip)
end
