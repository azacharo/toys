toys=$1
r=$2
run=$3
cat=$4
chan=$5
seed=$6
method=FitDiagnostics
datacard=datacard_${cat}_${chan}.txt
output=_${cat}_${chan}_Gen${toys}_signal${r}_run${run}
fileToys=higgsCombine${output}.GenerateOnly.mH120.${seed}.root
echo toysFile=$fileToys
echo execute combine -M $method -d $datacard -n $output --toysFile=$fileToys --expectSignal=$r --bypassFrequentistFit -t $toys  --skipBOnlyFit --saveToys --saveShapes --saveOverallShapes --saveWithUncertainties --saveNormalizations
combine -M $method -d $datacard -n $output --toysFile=$fileToys --expectSignal=$r --bypassFrequentistFit -t $toys  --skipBOnlyFit --saveToys --saveShapes --saveOverallShapes --saveWithUncertainties --saveNormalizations
