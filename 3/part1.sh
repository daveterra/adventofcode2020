#!/bin/bash

IFS=$'\n'
treesHit=0
column=0
tree="#"

for line in $(cat input.txt)
do
  len=${#line}
  index=$((column % len))
  symbol=${line:$index:1}

  if [ $symbol = $tree ]
  then
    treesHit=$((treesHit + 1))
  fi

  column=$((column +3))
done


echo "$treesHit trees hit"
