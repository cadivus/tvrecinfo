#!/bin/bash

scriptdir=$(cd $(dirname $0); pwd -P)

first=$(ls -R -1 /media/NAS/Filme/)

#needs to be configured the right way
mediathekview -auto
$scriptdir/sort__Letzte_Spur_Berlin.sh
$scriptdir/sort__SOKO_Leipzig.sh
$scriptdir/sort__Tatort.sh

second=$(ls -R -1 /media/NAS/Filme/)

echo ""
echo ""
echo ""
echo "Unterschied:"
diff <(echo "$first") <(echo "$second")

date=$(date +'%Y-%m-%d__%H_%M_%S')
echo "" &>> /media/NAS/MediathekView/log/download_history.log
echo "" &>> /media/NAS/MediathekView/log/download_history.log
echo "$date:" &>> /media/NAS/MediathekView/log/download_history.log
diff <(echo "$first") <(echo "$second") &>> /media/NAS/MediathekView/log/download_history.log
