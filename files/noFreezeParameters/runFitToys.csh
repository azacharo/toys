toys=$1
r=$2
run=$3
cat=$4
seed=$5
automc=$6
method=FitDiagnostics
datacard=datacard_${cat}.txt
output=_${cat}_Gen${toys}_signal${r}_run${run}
mcStatsOpt='* autoMCStats 10 0 1'
if [[ $automc == "on" ]]
then 
    if grep -Fxq "$mcStatsOpt" ${datacard}
    then 
        echo option is already there, datacard is ok 
    else 
        echo "$mcStatsOpt" >> ${datacard}
    fi 
fi
if [[ $automc == "off" ]]
then 
    output=${output}_noAutoMCStats
    if grep -Fxq "$mcStatsOpt" ${datacard}
    then
        sed -i '$d' ${datacard}
    else
        echo option is not there, datacard is ok 
    fi
fi
fileToys=higgsCombine${output}.GenerateOnly.mH120.${seed}.root
echo toysFile=$fileToys
echo execute combine -M $method -d $datacard -n $output --toysFile=$fileToys --expectSignal=$r --bypassFrequentistFit -t $toys  --skipBOnlyFit --saveToys --saveShapes --saveOverallShapes --saveWithUncertainties --saveNormalizations -s ${seed}
combine -M $method -d $datacard -n $output --toysFile=$fileToys --expectSignal=$r --bypassFrequentistFit -t $toys  --skipBOnlyFit --saveToys --saveShapes --saveOverallShapes --saveWithUncertainties --saveNormalizations -s ${seed}
if grep -Fxq "$mcStatsOpt" ${datacard}
then
    sed -i '$d' ${datacard}
fi
