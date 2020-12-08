#!/bin/bash

back="B"
right="R"

decodePassPart() {
  local code=$1
  local up=$2

  local len=${#1}
  local upper=$(( (2**len) - 1))
  local lower=0

  # Binary search
  for i in $(seq 0 $((len-1)))
  do
    local char=${code:$i:1}
    local mid=$(( (upper+lower+1)/2 ))
    if [ $char == $up ]
    then
      # Adjust lower bound
      lower=$mid
    else
      # Adjust upper bound
      upper=$(( mid - 1 ))
    fi
  done

  return $upper
}

iteratePasses() {
  local high=0
  local seatIDs=""

  while read pass
  do
    if [ -n $pass ]
    then
      rowCode=${pass:0:7}
      decodePassPart $rowCode $back
      row=$?
      seatCode=${pass:7:3}
      decodePassPart $seatCode $right
      seat=$?
      test=$(( (row*8) + seat ))
      seatIDs+=" $test"
    fi
  done < input.txt

  echo $seatIDs
}


seatIDs=$(iteratePasses)
sorted=$( echo $seatIDs | xargs -n1 | sort -nr )
high=$( echo $sorted | xargs -n1 | head -1 )
echo "$high is highest number"

IFS=$'\n'
last=$((high+1))
for seat in $sorted
do
  temp=$((last-1))
  if [ $temp -ne $seat ]
  then
    echo "$temp is your seat number"
    exit
  fi

  last=$seat
done
