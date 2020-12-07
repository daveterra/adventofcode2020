#!/bin/bash

IFS=$'\n'
count=0

for line in $(cat input.txt)
do
  #Parse the line into useful variables
  lowerBound=(${line%%"-"*})
  line=${line#*"-"}
  upperBound=(${line%%" "*})
  line=${line#*" "}
  letter=(${line%%":"*})
  line=${line#*" "}
  password=$line

  # Take all the other letters out of password, leaving only instances `letter`
  stripped=${password//[^$letter]}
  # This makes it easy to count the number of occurances of `letter`
  length=${#stripped}

  # See if it meets our requirements
  if [ $length -lt $lowerBound ] || [ $length -gt $upperBound ]
  then
    continue
  else
    count=$((count + 1))
  fi
done

echo "Number of valid passwords is $count"
