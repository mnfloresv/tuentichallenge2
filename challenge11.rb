# Challenge 11:  Descrambler - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ruby challenge11.rb

require 'set'

ALPHABET = (?A..?Z).to_a.join
FILE = "descrambler_wordlist.txt"

@scores = Hash.new {|h,k| h[k] = calc_score(k) } # calc one time, on demand

def calc_score(word)
  score=0

  word.chars do |c|
    score += case c
      when ?A, ?E, ?I, ?L, ?N, ?O, ?R, ?S, ?T, ?U then 1
      when ?D, ?G then 2
      when ?B, ?C, ?M, ?P then 3
      when ?F, ?H, ?V, ?W, ?Y then 4
      when ?K then 5
      when ?J, ?X then 8
      when ?Q, ?Z then 10
      else 0
    end
  end

  score
end

def best_word(rack, board)
  donthave = ALPHABET.delete(rack)
  dontuse = Set.new
  word=""
  score=0

  board.chars.to_a.uniq.each do |b|
    dontuse << donthave.delete(b)
  end

  totry=Set.new
  dontuse.each do |cad|
    possible = `grep -ve "[#{cad}]" #{FILE}`
    totry.merge possible.split
  end

  totry.each do |w|
    if w.delete(rack).size<2
      candidate = w.dup
      rack.chars do |r|
        candidate.sub!(r, '')
      end

      if candidate.length==1 && board.include?(candidate)
        s = @scores[w]
        if s>score || s==score && w < word
          word = w
          score = s
        end
      end
    end
  end

  "%s %d" % [word, score]
end

readline.to_i.times do
  rack, board = readline.strip.split
  puts best_word(rack, board)
end
