#!/bin/bash

# Read the input, but sort it too.
input=($(cat input.txt | sort -n))
num_items=${#input[*]}
start=0
end=$((num_items-1))
target=2020

while [ $start -lt $end ]
do
  a=${input[$start]}
  b=${input[$end]}
  sum=$((a + b))
  if [ $sum -lt $target ]
  then
    start=$(($start + 1))
  elif [ $sum -gt $target ]
  then
    end=$((end - 1))
  else
    echo "WINNER!"
    c=$((a*b))
    echo "$a * $b = $c"
    exit
  fi
done
