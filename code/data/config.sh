#!/bin/bash
echo "export PATH=$PATH:$HADOOP_PREFIX/bin" > ~/.bashrc
echo "export HADOOP_CLASSPATH=${JAVA_HOME}/lib/tools.jar" >> ~/.bashrc
echo -e "\033[0;31mPlease type \033[4;31msource ~/.bashrc\033[0;31m to activate the configuration. This script bash can't do that for you.\033[0m"
read -n1 -s
