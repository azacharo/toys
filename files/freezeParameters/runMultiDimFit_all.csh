#!/bin/bash
toys=$1
free=(none ST TTbar ST_TTbar)
cat=(cat0_mu cat0_el)
rExp=(0.5 1 1.5 2)
freezeParamINIT=yield_ST,yield_TTbar,yield_DY,yield_diboson,yield_cc,yield_udsg
echo initially ${freezeParamINIT}

for iparam in "${free[@]}"
do 
    echo free $iparam
    remove=""
    if [[ $iparam == "none" ]];
    then
        remove=${remove}
    fi
    if [[ ${iparam} == "ST" ]];
    then 
        remove="yield_ST,"
    elif [[ ${iparam} == "TTbar" ]];
    then 
        remove="yield_TTbar,"
    elif [[ ${iparam} == "ST_TTbar"  || ${iparam} == "TTbar_ST" ]];
    then
        remove="yield_ST,yield_TTbar,"
    fi
    echo to be removed ${remove}
    freezeParamFree="${freezeParamINIT//$remove/}"
    echo freezeParamFree ${freezeParamFree}
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
        echo $icat " " ${freezeParam}

        for ir in "${rExp[@]}"
        do 
            ./runMultiDimFit_freezeParam.csh ${toys} ${ir} ${icat} ${freezeParam} ${iparam}
        done
        freezeParam=${freezeParamFree}
    done
done
