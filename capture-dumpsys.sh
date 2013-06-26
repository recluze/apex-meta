#!/bin/bash 
# main log directory and files 
LOG_DIR=~/mydroid.meta/ 
CPUINFO_FILE=dumpsys-cpuinfo 
MEMINFO_FILE=dumpsys-meminfo 
LOG_FILE=dumpsys-combined

# Delay in seconds 
DELAY_BETWEEN_MEASURES=10


date2stamp () {
    date --utc --date "$1" +%s
}

stamp2date (){
    date --utc --date "1970-01-01 $1 sec" "+%Y-%m-%d %T"
}

dateDiff (){
    case $1 in
        -s)   sec=1;      shift;;
        -m)   sec=60;     shift;;
        -h)   sec=3600;   shift;;
        -d)   sec=86400;  shift;;
        *)    sec=86400;;
    esac
    dte1=$(date2stamp $1)
    dte2=$(date2stamp $2)
    diffSec=$((dte2-dte1))
    if ((diffSec < 0)); then abs=-1; else abs=1; fi
    echo $((diffSec/sec*abs))
}

START_TIME=`date +"%H:%M:%S"`; 

while true; do
	echo "========================  NEW ENTRY ===================== " >> $LOG_DIR/$LOG_FILE
	NOW_TIME=`date +"%H:%M:%S"`; 
        echo -n "Time of measurement: " >> $LOG_DIR/$LOG_FILE  
	dateDiff -s "$NOW_TIME" "$START_TIME" >> $LOG_DIR/$LOG_FILE 
	echo "---- CPU INFO -----" >> $LOG_DIR/$LOG_FILE
        adb shell dumpsys cpuinfo >> $LOG_DIR/$LOG_FILE

	echo "---- MEM INFO -----" >> $LOG_DIR/$LOG_FILE
        adb shell dumpsys meminfo "system" >> $LOG_DIR/$LOG_FILE

	echo "---- BATTERY INFO -----" >> $LOG_DIR/$LOG_FILE
        adb shell dumpsys battery >> $LOG_DIR/$LOG_FILE

	echo >> $LOG_DIR/$LOG_FILE
	echo >> $LOG_DIR/$LOG_FILE
	sleep $DELAY_BETWEEN_MEASURES
done 

