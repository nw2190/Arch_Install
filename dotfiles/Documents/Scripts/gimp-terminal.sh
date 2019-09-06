#!/bin/bash

file="$1"

gimp "${file}" 2>/dev/null &!
