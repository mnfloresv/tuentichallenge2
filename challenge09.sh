#!/bin/sh

# Challenge 9:  Il nomme della magnolia - Tuenti Programming Challenge 2
# Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
# Usage: ./challenge09.sh

DOCS_PATH="./documents/"
MAXDOC=800

document_line_position() {
  word=$(echo $1 | tr [A-Z] [a-z])
  count=0
  document=0

  while [ $count -lt $2 ]; do
    document=$(($document+1))
    filename=$DOCS_PATH/`printf "%04d" $document`

    if [ $document -gt $MAXDOC ]; then
      echo 0-0-0 # the word doesn't appear
      return
    fi

    # get the content of the lines that have matches, one word per line,
    # the first word of each line has a prefix with the line number
    # "grep -i" (case insensitive) is too slow, apply "tr" instead
    # "grep -w" (word) has a bug in busybox: https://bugs.busybox.net/show_bug.cgi?id=4520
    matches=$(cat $filename | tr [A-Z] [a-z] | grep -ne "\b$word\b" | tr " " "\n")
    
    words=$(echo "$matches" | grep -ce "\b$word\b") # count matches in doc
    count=$(($count+$words))
  done

  count=$(($count-$words)) # words at start of doc
  matches=$(echo $matches | sed 's/:/:\n/g') # "line:\nword1\nword2\nline:\nword3"

  for w in $matches; do
    case $w in
      *:)
        line=$(echo $w | cut -d: -f1)
        position=0
        ;;
      $word)
        position=$(($position+1))
        count=$(($count+1))
        if [ $count -eq $2 ]; then
          echo $document-$line-$position
          return
        fi
        ;;
      *)
        position=$(($position+1))
        ;;
    esac
  done

  echo 0-0-0 # the word doesn't appear n times
}

read cases

for c in `seq 1 $cases`; do
  read word n
  document_line_position $word $n
done
