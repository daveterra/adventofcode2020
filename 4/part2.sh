#!/bin/bash


checkHeight() {
  height=$1
  if [ -z ${height%%*cm*} ] && [ ${height%%cm*} -ge 150 ] && [ ${height%%cm*} -le 193 ]; then return 0; fi
  if [ -z ${height%%*in*} ] && [ ${height%%in*} -ge 59 ] && [ ${height%%in*} -le 76 ]; then return 0; fi
  return 1
}

checkHair() {
  hair=$1
  pattern="^#[0-9a-f]{6}$"
  if [[ $hair =~ $pattern ]]
  then
    return 0
  fi

  return 1
}

checkEyes() {
  eyes=$1
  pattern="^(amb|blu|brn|gry|grn|hzl|oth)$"
  if [[ $eyes =~ $pattern ]]
  then
    return 0
  fi

  return 1
}

checkPID() {
  pid=$1

  pattern="^[0-9]{9}$"
  if [[ $pid =~ $pattern ]]
  then
    return 0
  fi

  return 1
}

checkPassport() {
  requiredFields="byr iyr eyr hgt hcl ecl pid"
  passport=$1

  IFS=$' '
  for item in $passport
  do
    field=${item%%":"*}
    value=${item##*":"}
    requiredFields=${requiredFields//$field}
    case $field in
      "byr")
        if [ ${#value} -ne 4 ] || [ $value -lt 1920 ] || [ $value -gt 2002 ]; then return 1; fi
        ;;
      "iyr")
        if [ ${#value} -ne 4 ] || [ $value -lt 2010 ] || [ $value -gt 2020 ]; then return 1; fi
        ;;
      "eyr")
        if [ ${#value} -ne 4 ] || [ $value -lt 2020 ] || [ $value -gt 2030 ]; then return 1; fi
        ;;
      "hgt")
        checkHeight $value || return 1
        ;;
      "hcl")
        checkHair $value || return 1
        ;;
      "ecl")
        checkEyes $value || return 1
        ;;
      "pid")
        checkPID $value || return 1
        ;;
    esac
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
