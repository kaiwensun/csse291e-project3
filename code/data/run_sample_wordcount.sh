#!/bin/bash

SIGN='\033[1;42mKevin:\033[0m'
cd WordCount

#In this docker image, there is already an /input/ directory in HDFS. Don't touch it.
printf "${SIGN} Making a directory at the hadoop file system.\n"
hadoop fs -mkdir -p myinput

printf "${SIGN} Uploading the input files to hadoop file system. the -put flag is equivalent to -copyFromLocal. The -f flag forces overwrite.\n"
hadoop fs -put -f file*.txt myinput

printf "${SIGN} Removing myoutput directory. The output should not exist.\n"
hadoop fs -rm -r -f myoutput

printf "${SIGN} Current files in hadoop file system are:\n"
hadoop fs -ls myinput

printf "${SIGN} Compiling WordCount.java\n"
hadoop com.sun.tools.javac.Main WordCount.java

printf "${SIGN} Creating wc.jar file\n"
jar cf wc.jar WordCount*.class

printf "${SIGN} Run wc.jar using hadoop\n"
hadoop jar wc.jar WordCount /user/root/myinput /user/root/myoutput

printf "${SIGN} Fetching the result from HDFS"
hadoop fs -cat myoutput/part-r-00000
