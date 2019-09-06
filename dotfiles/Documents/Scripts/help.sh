#!/bin/bash

## Define the help message to display
helpmessage="$(basename "$0") [-h] [-s str] -- Example help output for Bash script
    -h  show this help text
    -s  set ouput string (default: 'Hello!')"

## Set a default value for the optional parameter -n
str='Hello!'

## Parse arguments
while getopts ':hs:' option; do
    case "$option" in
	h) echo "$helpmessage"
	   exit
	   ;;
	s) str=${OPTARG}
	   ;;
	:) printf "missing argument for -%s\n" "$OPTARG" >&2
	   echo "$helpmessage" >&2
	   exit 1
	   ;;
	\?) printf "illegal option: -%s\n" "$OPTARG" >&2
	    echo "$helpmessage" >&2
	    exit 1
	    ;;
    esac
done

## Shift positional arguments (so that $1 is first required arg)
shift $((OPTIND - 1))

## Execute main script
echo "${str}"
