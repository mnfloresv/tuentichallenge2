#!/bin/sh

# Challenge 8: The demented cloning machine - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ./challenge08.sh

# Calculate the md5 while the ruby program is printing using the power of the pipe,
# and omit the additional hyphen.

ruby challenge08.rb | md5sum | tr -d ' -'
