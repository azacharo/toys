
toys=$1
r=$2
cat=$3
freezeParam=$4
freeParam=$5
automc=$6
fileExt=freezeAll_free_${freeParam}
if [[ $automc == "off" ]];
then 
    fileExt=${fileExt}_noAutoMCStats
fi
# fileExt=freezeAll_free_${freeParam}
# fileExt=freezeAll_free_${freeParam}_noAutoMCStats
method=GenerateOnly
datacard=datacard_${cat}.txt
mcStatsOpt='* autoMCStats 10 0 1'
# echo "$mcStatsOpt"
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
    if grep -Fxq "$mcStatsOpt" ${datacard}
    then
        sed -i 'd' ${datacard}
    else 
        echo option is not there, datacard is ok
    fi
fi
output=_${cat}_Gen${toys}_signal${r}_${fileExt}
echo execute combine -M $method -d $datacard -n $output --bypassFrequentistFit -t $toys --expectSignal=$r --saveToys --freezeParameters ${freezeParam}
combine -M	$method	-d $datacard -n	$output	 --bypassFrequentistFit -t $toys --expectSignal=$r --saveToys --freezeParameters ${freezeParam}
if grep -Fxq "$mcStatsOpt" ${datacard}
then
    sed -i '$d' ${datacard}
fi
