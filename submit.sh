#! /bin/bash

source $JAVA_HOME
source $HADOOP_HOME
export PATH=$PATH:$SPARK_HOME:/app/jdk/bin/
spark-submit scala_dir_2.11-0.1-SNAPSHOT.jar --class $SPARK_PROGRAM_CLASS $sPARK_PROGRAM_JAR


