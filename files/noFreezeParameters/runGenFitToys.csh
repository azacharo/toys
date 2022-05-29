#!/bin/bash
cat=(cat0)
chan=(mu el)
array=(0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5)
seed=100000
for ichan in "${chan[@]}"
do
  for icat in "${cat[@]}"
  do
    for j in "${array[@]}"
    do
       for ((i=1;i<=100;i++)); 
       do
          seed=$((10000+$i))
          output=_${icat}_${ichan}_Gen1_signal${j}_run${i}
          fileToys=higgsCombine${output}.GenerateOnly.mH120.${seed}.root
          fileToys2=higgsCombine${output}.FitDiagnostics.mH120.123456.root
          ./runGenToys.csh 1 $j $i $icat $ichan $seed
          ./runFitToys.csh 1 $j $i $icat $ichan $seed
          rm ${fileToys}
          rm ${fileToys2}
       done
    done
  done
done


