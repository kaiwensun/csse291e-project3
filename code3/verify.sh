#!/bin/bash
printf '\033[1;32m'
diff -s data/WordCount/computed.result data/WordCount/expected.result 
printf '\033[0m'
