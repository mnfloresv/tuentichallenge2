# Challenge 6: Cross-stitched fonts - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge06.rb

# Try to stitch all the words in a cloth of dimensions x and y with the given font size
def trystitch(wordslength, x, y, font)
  m=0 # width
  n=font # height

  wordslength.each do |wl|
    wlsp = m>0 ? 1+wl : wl # count a space when is not the first word in this line

    if m + wlsp*font <= x # if fits in this line
      m+=wlsp*font
    elsif n + font <= y && wl*font <= x # if we can stitch a new line and the word fits in it
      n+=font
      m=wl*font
    else # we can't stitch all the text
      return false
    end
  end

  true
end

# Calculates the maximum font size using binary search
def fontsize(cad, x, y)
  wordslength = cad.split.map {|x| x.length}
  max = [x, y].min
  min = 0
  while min < max
    font=(min+max+1)/2
    if trystitch(wordslength, x, y, font)
      min=font
    else
      max=font-1
    end
  end
  max
end

# Calculates the thread length needed
def threadlength(cad, w, h, ct)
  font = fontsize(cad, w*ct, h*ct)
  chars = cad.length - cad.count(" ")
  thread = chars * font**2/2 * 1.0/ct
  thread.ceil
end

readline.to_i.times do |i|
  w, h, ct = readline.split.map {|x| x.to_i}
  cad = readline.strip
  printf "Case #%d: %d\n", i+1, threadlength(cad, w, h, ct)
end
