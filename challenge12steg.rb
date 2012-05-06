# Challenge 12:  Three keys one cup - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge12steg.rb

# This program prints the key hidden using steganography needed for the challenge 12

require 'chunky_png'
include ChunkyPNG

image = Image.from_file("CANTTF.png")
size = 32
lsb = []

# iterate over the first pixels, calculate how many are needed
(size*8/3+1).times do |i|
  # get the less significant bit of each color component
  pixel = image[i, 0]
  lsb << Color.r(pixel) % 2 << Color.g(pixel) % 2 << Color.b(pixel) % 2
end

# and convert from binary to ascii
lsb[0..size*8-1].each_slice(8) do |byte|
  printf "%c", byte.join.to_i(2).chr
end

printf "\n"
