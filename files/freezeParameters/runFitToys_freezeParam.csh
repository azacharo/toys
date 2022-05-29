toys=$1
r=$2
cat=$3
freezeParam=$4
freeParam=$5
fileExt=freezeAll_free_${freeParam}
method=FitDiagnostics
datacard=datacard_${cat}.txt
output=_${cat}_Gen${toys}_signal${r}_${fileExt}
fileToys=higgsCombine${output}.GenerateOnly.mH120.123456.root
echo toysFile=$fileToys
echo execute combine -M $method -d $datacard -n $output --toysFile=$fileToys  --bypassFrequentistFit -t $toys --expectSignal=$r --saveToys --freezeParameters ${freezeParam}
combine -M $method -d $datacard -n $output --toysFile=$fileToys  --bypassFrequentistFit -t $toys --expectSignal=$r --saveToys --freezeParameters ${freezeParam}
