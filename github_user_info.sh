#!/bin/bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

## Show Uses
if [ "$#" -ne 0 ]; then
  ## Showing uses -h
  while [[ "$1" =~ ^- && "$1" != "--" ]]; do
    case $1 in
      -h | --help )
        echo "Uses: $0 [username]"
        exit
        ;;
      *)
        >&2 echo "Invalid argument!"
        exit
        ;;
    esac; 
    shift; 
  done

  ## --help
  if [[ "$1" == '--' ]]; then
    shift;
  fi
fi

## Command line parameter:
targetuser="${1:-mhausenblas}"

## Check if our dependencies are met:
if ! [ -x "$(command -v jq)" ]; then
  echo "jq is not installed" >&2
  exit 1
fi

if ! [ -x "$(command -v curl)" ]; then
  echo "curl is not installed" >&2
  exit 1
fi


## Main:
githubapi="https://api.github.com/users/"
tmpuserdump="/tmp/ghuserdump_$targetuser.json"

## Check if valid username
response=$(curl -s -o /dev/null -w "%{http_code}" $githubapi$targetuser)
if [ $response != 200 ]; then
  echo "$targetuser is not found" >&2
  exit 1
fi


result=$(curl -s $githubapi$targetuser)
echo $result > $tmpuserdump

name=$(jq .name $tmpuserdump -r)
created_at=$(jq .created_at $tmpuserdump -r)

joinyear=$(echo $created_at | cut -d"-" -f1)
echo $name joined GitHub in $joinyear