#!/bin/bash

FILE=data
SOL_SRC=../sol/sol.cpp
SOL=../sol/sol.exe
MAN_DIR=manual
TESTDATA_DIR=../testdata

if ! [[ -f $FILE ]]; then
  echo "'data' file does not exist, do you run this script under 'res/gen' directory?"
  exit
fi

if ! [[ -f $SOL_SRC ]]; then
  echo "'sol.cpp' file does not exist."
  exit
else
  g++ $SOL_SRC -o $SOL
fi

if ! [[ -d $TESTDATA_DIR ]]; then
  mkdir $TESTDATA_DIR
fi

cnt=1
while read line; do
  splitted=($line)
  command=${splitted[0]}
  if [[ $command == man ]]; then
    cat ${MAN_DIR}/${splitted[1]} > ${TESTDATA_DIR}/${cnt}.in
  else
    if ! [[ -f ${splitted[0]} ]]; then
      if [[ -f ${splitted[0]}.cpp ]]; then
        g++ ${splitted[0]}.cpp -o ${splitted[0]}.exe
      else
        echo "${splitted[0]}.cpp file does not exist."
        exit
      fi
    fi
    splitted[0]=${splitted[0]}.exe
    ./${splitted[@]} > ${TESTDATA_DIR}/${cnt}.in
  fi

  ${SOL} < ${TESTDATA_DIR}/${cnt}.in > ${TESTDATA_DIR}/${cnt}.out
  echo "gen testcase $cnt success."

  cnt=$((cnt+1))
done < "$FILE"

rm $SOL
rm *.exe
