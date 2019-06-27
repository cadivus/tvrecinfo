#!/bin/bash

mediathekViewDir="/media/NAS/MediathekView"
movieDir="/media/NAS/Filme"

scriptdir=$(cd $(dirname $0); pwd -P)
first=$(ls -R -1 $movieDir)

#needs to be configured the right way
mediathekview -auto
$scriptdir/sort__Letzte_Spur_Berlin.sh
$scriptdir/sort__SOKO_Leipzig.sh
$scriptdir/sort__Tatort.sh

second=$(ls -R -1 $movieDir)

echo ""
echo ""
echo ""
echo "Unterschied:"
diff <(echo "$first") <(echo "$second")

date=$(date +'%Y-%m-%d__%H_%M_%S')
echo "" &>> $mediathekViewDir/log/download_history.log
echo "" &>> $mediathekViewDir/log/download_history.log
echo "$date:" &>> $mediathekViewDir/log/download_history.log
diff <(echo "$first") <(echo "$second") &>> $mediathekViewDir/log/download_history.log

