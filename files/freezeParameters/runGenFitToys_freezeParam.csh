#!/bin/bash
freeParam=$1
toys=$2
automc=$3
cat=(cat01_muel)

rExp=(0.5 1 1.5 2)
freezeParamINIT=yield_ST,yield_TTbar,yield_DY,yield_diboson,yield_cc,yield_udsg
#echo initially freezeParam ${freezeParamINIT}
remove=""
if [[ $freeParam == "none" ]];
then
  remove=${remove}
fi
if [[ ${freeParam} == "ST" ]];
then 
  remove="yield_ST,"
elif [[ ${freeParam} == "TTbar" ]];
then 
  remove="yield_TTbar,"
elif [[ ${freeParam} == "ST_TTbar"  || ${freeParam} == "TTbar_ST" ]];
then
  remove="yield_ST,yield_TTbar,"
fi
#echo to be removed ${remove}
freezeParamFree="${freezeParamINIT//$remove/}"
#echo freezeParamFree ${freezeParamFree}
freezeParam=${freezeParamFree}
for icat in "${cat[@]}"
do
  if [[ $icat =~ "mu" ]] ;
  then
    freezeParam=${freezeParam}",yield_qcd_mu"
  fi
  if [[ $icat =~ "el" ]];
  then
    freezeParam=${freezeParam}",yield_qcd_el"
  fi
  if [[ $icat =~ "0" ]];
  then 
    freezeParam=${freezeParam}",QCD_SR_shape"
  fi
  if [[ $icat =~ "1" ]];
  then 
    freezeParam=${freezeParam}",QCD_ST_shape"
  fi
  if [[ $icat =~ "2" ]];
  then
    freezeParam=${freezeParam}",QCD_CRmetINV_shape"
  fi
  #echo $icat freezeParam ${freezeParam}
  
  for j in "${rExp[@]}"
  do  
    output=_${icat}_Gen${toys}_signal${j}_freezeAll_free_${freeParam}
    if [[ $automc == "off" ]]
    then
      output=${output}_noAutoMCStats
    fi

    fileToys=higgsCombine${output}.GenerateOnly.mH120.123456.root
    fileToys2=higgsCombine${output}.FitDiagnostics.mH120.123456.root
    ./runGenToys_freezeParam.csh ${toys} $j $icat ${freezeParam} ${freeParam} ${automc}
    ./runFitToys_freezeParam.csh ${toys} $j $icat ${freezeParam} ${freeParam} ${automc}
    rm ${fileToys}
    rm ${fileToys2}
    # fitFile=fitDiagnostics${output}.root
    # mv ${fitFile} files/free_${freeParam} 
  done
  freezeParam=${freezeParamFree}
  #echo $icat at the end freezeParam ${freezeParam}
  #echo ""

done