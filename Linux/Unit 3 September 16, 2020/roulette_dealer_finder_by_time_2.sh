#!/bin/bash
grep 'AM\|PM' *schedule | awk -F'[_:"\t" ]' '{print $1, "\t", $4, $5, $7, "\t", $10, $11}'| grep $1 | awk -F" " '{print $1,$2,$4,$5,$6}' | grep $2
