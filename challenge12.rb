# Challenge 12:  Three keys one cup - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge12.rb

key1 = "ed8ce15da9b7b5e2ee70634cc235e363" # qr code
key2 = "a541714a17804ac281e6ddda5b707952" # metadata
key3 = "62cd275989e78ee56a81f0265a87562e" # steganography

input = readline

32.times do |i|
  hex = ( key1[i].to_i(16) + key2[i].to_i(16) + key3[i].to_i(16) + input[i].to_i(16) ) % 16
  printf "%x", hex
end

printf "\n"
