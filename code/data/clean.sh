#!/bin/bash

SIGN='\033[1;42mKevin:\033[0m'

printf "${SIGN} Removing *.class and *.jar\n"
rm -f WordCount/*.class WordCount/*.jar

printf "${SIGN} Removing files in HDFS\n"
hadoop fs -rm -r -f -skipTrash myinput myoutput
