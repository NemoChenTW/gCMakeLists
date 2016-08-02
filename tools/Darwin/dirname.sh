#!/bin/bash
# Recursive dirname

while [[ $# > 0 ]]; do
	dirname $1
	shift
done