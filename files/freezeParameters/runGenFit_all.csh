#!/bin/bash
toys=$1
free=(none ST TTbar ST_TTbar)
for iparam in "${free[@]}"
do 
    ./runGenFitToys_freezeParam.csh $iparam ${toys}
done