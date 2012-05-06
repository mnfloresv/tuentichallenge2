# Challenge 4: 20 fast 20 furious - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge04.rb

# Returns the number of groups and the number of karts used for a race
def race(karts, groups)
  g=k=0
  while g<groups.size && k+groups[g]<=karts
    k+=groups[g]
    g+=1
  end
  [g, k]
end

# Returns the litres needed for our karting
def litres(races, karts, groups)
  litres=0
  rot=0 # counts the number of groups that have made a race
  h={}
  races.times do |race|
    g,k=race(karts, groups.rotate(rot))
    rot=(rot+g)%groups.size
    litres+=k

    if h.has_key? rot then # when reaches a previously known position
      hrace, hlitres = h[rot] # get values for the first time
      cycles=(races-hrace-1)/(race-hrace) # calculate how many times it repeats the same
      return hlitres + (litres-hlitres)*cycles + litres(races-(race-hrace)*cycles-hrace-1, karts, groups.rotate(rot))
    else
      h[rot] = [race, litres] # stores the litres needed from the beginning until this position is reached the first time
    end
  end
  litres
end

readline.to_i.times do
  r,k,g=readline.split.map {|x| x.to_i}
  groups=readline.split.map {|x| x.to_i}
  puts litres(r, k, groups)
end
