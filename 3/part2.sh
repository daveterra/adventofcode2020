#!/bin/bash

tree="#"

findTreesHit() {
  rise=$1
  run=$2
  treesHit=0
  column=0
  row=1

  IFS=$'\n'
  for line in $(cat input.txt)
  do
    row=$((row + 1))
    if [ $((row % rise)) -ne 0 ]
    then
      continue
    fi

    len=${#line}
    index=$((column % len))
    symbol=${line:$index:1}

    if [ $symbol = $tree ]
    then
      treesHit=$((treesHit + 1))
    fi

    column=$((column + run))
  done

  echo "$treesHit trees hit"
  return $treesHit
}

findTreesHit 1 1
a=$?
findTreesHit 1 3
b=$?
findTreesHit 1 5
c=$?
findTreesHit 1 7
d=$?
findTreesHit 2 1
e=$?

f=$((a*b*c*d*e))
echo "$a * $b * $c * $d * $e = $f"
