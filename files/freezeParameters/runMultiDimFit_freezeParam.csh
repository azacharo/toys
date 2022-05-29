toys=$1
r=$2
cat=$3
freezeParam=$4
freeParam=$5
fileExt=freezeAll_free_${freeParam}
#fileExt=freezeAll_free_${freeParam}_noAutoMCStats
if [[ $toys == "-1" ]];
then 
    fileExt=${fileExt}_Asimov
fi
method=MultiDimFit
datacard=datacard_${cat}.txt
output=_${cat}_signal${r}_${fileExt}
echo execute combine -M $method -d $datacard -n $output --algo=grid --points=100 -t $toys --expectSignal=$r --freezeParameters ${freezeParam}
combine -M $method -d $datacard -n $output --algo=grid --points=100 -t ${toys} --expectSignal=$r --freezeParameters ${freezeParam}
