#!/bin/bash
automc=$1
#cat=(cat01_mu cat01_el cat01_muel cat012_mu cat012_el cat012_muel)
cat=(cat01_muel)
#array=(0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3 2.4 2.5)
rExp=(0.5 1 1.5 2)

seed=100000
for icat in "${cat[@]}"
do
  for j in "${rExp[@]}"
  do
    for ((i=0;i<=100;i++)); 
    do
      seed=$((10000+$i))
      output=_${icat}_Gen1_signal${j}_run${i}
      if [[ $automc == "off" ]]
      then
        output=${output}_noAutoMCStats
      fi
      fileToys=higgsCombine${output}.GenerateOnly.mH120.${seed}.root
      fileToys2=higgsCombine${output}.FitDiagnostics.mH120.${seed}.root
      ./runGenToys.csh 1 $j $i $icat $seed $automc
      ./runFitToys.csh 1 $j $i $icat $seed $automc
      rm ${fileToys}
      rm ${fileToys2}
      # fitFile=fitDiagnostics${output}.root
      # mv ${fitFile} ${icat}_${ichan}/files/
    done
  done
done

