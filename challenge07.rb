# Challenge 7: The "secure" password - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge07.rb

# A tree is a hash where each key is the first character of a subcode, and each
# value is an array with all the subcodes that start with his key.

# Populates the tree with new subcodes
def populate(tree, subcodes)
  subcodes.each do |subcode|
    head, tail = subcode[0], subcode[1..-1]
    if tree.has_key? head
      tree[head] << tail if tail.length > 0
    else
      tree[head] = tail.length>0 ? [tail] : []
    end
  end
  tree
end

# Prints all the posible password
def backtracking(tree, password="")
  if tree.empty?
    puts password
  else # get the characters that appears only at the beginning of a subcode
    tails = tree.values.flatten
    q1 = tree.keys.select do |head|
      not tails.any? do |tail|
        tail.include? head
      end
    end

    q1.sort.each do |x| # for each of these characters
      # take it as the current character of the password and apply recursively with the rest
      tree2 = Marshal.load(Marshal.dump(tree)) # a deep copy
      tree2.delete(x)
      tree2 = populate(tree2, tree[x])
      backtracking(tree2, password+x)
    end
  end
end

subcodes = []

STDIN.each_line do |subcode|
  if !subcode.strip.empty?
    subcodes << subcode.strip
  end
end

tree = populate({}, subcodes)
backtracking(tree)
