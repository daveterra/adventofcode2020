#!/bin/bash

evalGroup() {
  input=$1
  count=$(echo $input | fold -w1 | sort | uniq | wc -l)
  echo $((count+0))
}

iterateGroups() {
  local input=$1
  group=""
  count=0
  while read line
  do
    group+=$line
    if [ -z "$line" ]
    then
      #evalGroup $group
      num=$(evalGroup $group)
      count=$((count + num))
      group=""
    fi
  done < $input
  echo $count
}

total=$(iterateGroups input.txt)
echo "Silly number is $total"
