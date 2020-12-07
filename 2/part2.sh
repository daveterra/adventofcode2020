#!/bin/bash

IFS=$'\n'
count=0

for line in $(cat input.txt)
do
  originalLine=$line

  #Parse the line into useful variables
  lowerBound=(${line%%"-"*})
  line=${line#*"-"}
  upperBound=(${line%%" "*})
  line=${line#*" "}
  letter=(${line%%":"*})
  line=${line#*" "}
  password=$line

  # Zero index these positions
  lowerBound=$((lowerBound-1))
  upperBound=$((upperBound-1))
  # Get characters at position
  first=${password:$lowerBound:1}
  second=${password:$upperBound:1}

  #See if it meets our requirements
  if [ $first = $second ]
  then
    continue
  elif [ $first = $letter ] || [ $second = $letter ]
  then
    count=$((count + 1))
  fi
 done

echo "Number of valid passwords is $count"
