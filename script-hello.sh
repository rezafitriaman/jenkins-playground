#!/bin/bash
FIRSTNAME=$1
SECONDNAME=$2
LASTNAME=$3
SHOW=$4

if [ "$SHOW" = "true" ]; then
  echo "Hello, $FIRSTNAME $SECONDNAME $LASTNAME"
else
  echo "If you want to see the name, please mark the show option"
fi