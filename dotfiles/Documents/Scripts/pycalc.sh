#!/bin/bash

# Retrieve query string
query="$1"
#echo $query

# Specify Python dependencies
dependencies="import numpy as np; "

# Construct Python command string with print statement
pythonstr="${dependencies} print(${query})"

# Evaluate Python string
python -c "${pythonstr}"
