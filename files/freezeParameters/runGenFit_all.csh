#!/bin/bash
toys=$1
automc=$2
free=(none ST TTbar ST_TTbar)
for iparam in "${free[@]}"
do 
    ./runGenFitToys_freezeParam.csh $iparam ${toys} ${automc}
done