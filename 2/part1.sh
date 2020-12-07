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

  # Take all the other letters out of password, leaving only "$letter"
  stripped=${password//[^$letter]}

  #See if it meets our requirements
  length=${#stripped}
  if [ $length -lt $lowerBound ] || [ $length -gt $upperBound ]
  then
    echo "Password invalid! $originalLine"
  else
    count=$((count + 1))
  fi
done

echo $count
