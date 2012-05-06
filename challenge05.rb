# Challenge 5: Time is never time again - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge05.rb

require 'time'

# ------------------------------------------------------------------------------

# Copy & paste of my solution for the clocks challenges of the last year contest

class OldClock
  # returns number of times that the leds turns on after s seconds
  def segments(s)
    seg=[6,2,5,5,4,5,6,3,7,6] # segments of each digit
    sum=seg.each_index.map {|i| seg[0..i].inject(0, :+)} # sum of segments from 0 to i
    sum+=[0]
    
    # calc basic units
    # hh:mm:ss
    ss = s%60
    mm = s/60%60
    hh = s/(60*60)%24
    # h2,h1:m2,m1:s2,s1
    s2,s1 = ss/10, ss%10
    m2,m1 = mm/10, mm%10
    h2,h1 = hh/10, hh%10

    # calc how many times each display turns on after s seconds
    # I should explain this mathematical formula
    b0 = sum[9]     *(s/10)    + sum[s1]
    b1 = sum[5]*10  *(s/60)    + sum[s2-1]*10    + seg[s2]*(              s1+1)
    b2 = sum[9]*60  *(s/600)   + sum[m1-1]*60    + seg[m1]*(              ss+1)
    b3 = sum[5]*600 *(s/3600)  + sum[m2-1]*600   + seg[m2]*(        m1*60+ss+1)
    b4 = sum[9]*3600*(s/36000) + sum[h1-1]*3600  + seg[h1]*(        mm*60+ss+1)
    b5 =                         sum[h2-1]*36000 + seg[h2]*(h1*3600+mm*60+ss+1)

    # return the sum of blinks of each display
    return b0+b1+b2+b3+b4+b5
  end

  # support for full days, when the clock position is reset
  def total_segments(s)
    day=86400
    if (s<day)
      return segments(s)
    else
      return segments(s%day) + segments(day-1)*(s/day)
    end
  end
end

class NewClock
  # returns number of times that the leds turns on after s seconds
  def segments(s)
    deltaseg=[0,0,4,1,1,2,1,1,4,0] # delta segments of each digit
    deltasum=deltaseg.each_index.map {|i| deltaseg[0..i].inject(0, :+)} # sum from 0 to i
    
    # calc basic units
    # hh:mm:ss
    ss = s%60
    mm = s/60%60
    hh = s/(60*60)%24
    # h2,h1:m2,m1:s2,s1
    s2,s1 = ss/10, ss%10
    m2,m1 = mm/10, mm%10
    h2,h1 = hh/10, hh%10

    # calc how many times each display turns on after s seconds
    # I should explain this mathematical formula
    b0 = 6 + (deltasum[9]+1)*(s/10)    + deltasum[s1]
    b1 = 6 + (deltasum[5]+2)*(s/60)    + deltasum[s2]
    b2 = 6 + (deltasum[9]+1)*(s/600)   + deltasum[m1]
    b3 = 6 + (deltasum[5]+2)*(s/3600)  + deltasum[m2]
    b4 = 6 + (deltasum[9]+1)*(s/36000) + deltasum[h1]
    b5 = 6 +                           + deltasum[h2]

    # return the sum of blinks of each display
    return b0+b1+b2+b3+b4+b5
  end

  # support for full days, when the clock position is reset
  def total_segments(s)
    day=86400
    if (s<day)
      return segments(s)
    else
      return segments(s%day) + (segments(day-1)-26)*(s/day)
    end
  end
end

# ------------------------------------------------------------------------------

# My solution for this challenge

# Add a method to get the number of seconds since midnight
class Time
  def seconds
    hour*3600 + min*60 + sec
  end
end

# Reopen the classes to add two methods that uses our previous code to solve this challenge
# the trick is subtrack the LEDs that turned on between midnight and the first date
#  [t1midnight] <- t1.seconds -> [t1] <------> [t2]

class OldClock
  def blinks_between(t1, t2)
    t1midnight = t1-t1.seconds
    offset = t1.seconds==0 ? 0 : total_segments(t1.seconds-1)
    t1<=t2 ? total_segments((t2-t1midnight).to_i)-offset : 0
  end
end

class NewClock
  def blinks_between(t1, t2)
    t1midnight = t1-t1.seconds
    if t1.seconds==0
      offset = 0
    else
      offset = total_segments(t1.seconds) - OldClock.new.blinks_between(t1, t1)
    end
    t1<=t2 ? total_segments((t2-t1midnight).to_i)-offset : 0
  end
end

clock1 = OldClock.new
clock2 = NewClock.new

STDIN.each_line do |line|
  t1, t2 = line.strip.split(" - ").map {|x| Time.parse x}
  b1 = clock1.blinks_between(t1, t2)
  b2 = clock2.blinks_between(t1, t2)
  puts b1-b2
end
