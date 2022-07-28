#!/bin/bash

declare -i default_scale=2
func=""
PI=3.1415

usage(){
  echo "Usage"
}

calculate(){
      # use * to replace x
      operate="$2"
      if [[ "$2" = "x" ]]; then
        operate="*"
      fi
      # check if $1 and $3 are decimal number
      if [[ $1 =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] && [[ $3 =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]
      then
        # check if $1 or $3 are float (real) number
        if [[ $1 =~ ^[+-]?[0-9]+\.[0-9]*$ ]] || [[ $3 =~ ^[+-]?[0-9]+\.[0-9]*$ ]]
        then
          # shellcheck disable=SC2046
          echo $(echo "scale = $default_scale; ($1 $operate $3) / 1" | bc)
        else
          # shellcheck disable=SC2046
          echo $(echo "scale = 0; ($1 $operate $3) / 1" | bc)
        fi
      # Input is not decimal number
      else
        echo "Incorrect input, please input decimal number"
      fi
}


while [ $# -gt 0 ]; do
  case "$1" in
    -h|-help)
      usage
      shift
      ;;
    -f)
      shift
      func="$1"
      shift
      ;;
    -s)
      shift
      default_scale="$1"
      shift
      ;;
    *)
      if [[ -z "$func" ]]; then
        calculate "$1" "$2" "$3"
      else
        if [[ "$func" = "hyp" ]]; then
          echo $(echo "scale = 10 ; sqrt( $1 ^ 2 + $2 ^ 2 ) /1 " | bc)
        elif [[ $func = "area" ]]; then
          echo $(echo "scale = 10 ; ( $1 ^ 2 * $PI ) /1" | bc)
        else
          echo "function not found"
        fi
      fi
      break
      ;;
  esac
done

