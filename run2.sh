#!/bin/bash

PROBLEM="pocman"
SIZE=1
NUM=10
LEVELT=1
LEVELR=1
RUNS=50
VERBOSE=0
USEPFILTER=1
REUSETREE=0
REUSEDEPTH=2
MINPOWER2=0
MAXPOWER2=17
SEEDING=0
TIMEOUT=3600
TIMEOUTPERACTION=-1

OUTPUT="D2NGOUTPUT_POCMAN1010-$$.txt"
LOG="logD2NG-$$.txt"

CPUS=`cat /proc/cpuinfo | grep processor | tail -n 1 | awk '{print $3}'`

while getopts "p:s:n:t:r:R:v:u:d:L:H:S:P:N:h:a:" OPTION; do
    case $OPTION in
        p) PROBLEM=$OPTARG ;;
        s) SIZE=$OPTARG ;;
        n) NUM=$OPTARG ;;
        t) LEVELT=$OPTARG ;;
        r) LEVELR=$OPTARG ;;
        R) RUNS=$OPTARG ;;
        v) VERBOSE=$OPTARG ;;
        u) REUSETREE=$OPTARG ;;
        d) REUSEDEPTH=$OPTARG ;;
        L) MINPOWER2=$OPTARG ;;
        H) MAXPOWER2=$OPTARG ;;
        S) SEEDING=$OPTARG ;;
        P) USEPFILTER=$OPTARG ;;
        N) MINPOWER2=$OPTARG; MAXPOWER2=$OPTARG ;;
        h) TIMEOUT=`expr $OPTARG \* 3600`;;
        a) TIMEOUTPERACTION=$OPTARG ;;
    esac
done

run() {
    echo "#$*" > $OUTPUT
    echo "#$*" | tee $LOG
    exec $* 2>&1 | tee -a $LOG
}


make -j `expr $CPUS + 1`
run ./d2ng-pomcp --outputfile $OUTPUT \
            --problem $PROBLEM \
            --size $SIZE \
            --number $NUM \
            --verbose $VERBOSE \
            --reusedepth $REUSEDEPTH \
            --reusetree $REUSETREE \
            --useparticlefilter $USEPFILTER \
            --treeknowledge $LEVELT \
            --rolloutknowledge $LEVELR \
            --mindoubles $MINPOWER2 \
            --maxdoubles $MAXPOWER2 \
            --runs $RUNS \
            --seeding $SEEDING \
            --timeout $TIMEOUT \
            --timeoutperaction $TIMEOUTPERACTION

