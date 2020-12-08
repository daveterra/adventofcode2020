#!/bin/bash

evalGroup() {
  input=(${@})
  possible="abcdefghijklmnopqrstuvwxyz"
  for each in ${input[@]}
  do
    possible=${possible//[^$each]}
  done
  return ${#possible}
}

iterateGroups() {
  local input=$1
  group=()
  count=0
  while read line
  do
    group+=($line)
    if [ -z "$line" ]
    then
      evalGroup ${group[@]}
      count=$(( count + $? ))
      group=()
    fi
  done < $input
  echo $count
}

total=$(iterateGroups input.txt)
echo "Silly number is $total"
