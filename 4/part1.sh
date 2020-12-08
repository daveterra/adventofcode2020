#!/bin/bash

checkPassport() {
  requiredFields="byr iyr eyr hgt hcl ecl pid"
  passport=$1

  IFS=$' '
  for item in $passport
  do
    field=${item%%":"*}
    requiredFields=${requiredFields//$field}
  done

  # Strip out the spaces
  requiredFields=${requiredFields//' '}

  return ${#requiredFields}
}

iteratePassports() {
  passport=""
  validPassports=0

  while read line
  do
    # Accumulate lines until we hit blank line (delim)
    passport+=" $line"

    if [ -z "$line" ]
    then
      # validate the accumulated passport string
      checkPassport "$passport"
      valid=$?

      if [ $valid -eq 0 ]
      then
        validPassports=$((validPassports + 1))
      fi

      # Reset passport string
      passport=""
    fi
  done < input.txt

  return $validPassports
}

iteratePassports
echo "$? valid passports"
