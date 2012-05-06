# Challenge 8: The demented cloning machine - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge08.rb

# This program prints the queue of people, for the md5 sum see: challenge08.sh

queue = readline.strip
transformations = []

STDIN.each_line do |serie|
  transformations << Hash[serie.strip.split(",").map {|x| x.split("=>") }]
end

alphabet = transformations.map(&:keys).flatten.uniq

clones = Hash.new {|h, k| h[k]=k }

alphabet.each do |char|
  transformations.each do |t|
    clones[char] = clones[char].gsub(/[#{t.keys.join}]/, t)
  end
end

queue.each_char {|char| STDOUT.write clones[char] }
