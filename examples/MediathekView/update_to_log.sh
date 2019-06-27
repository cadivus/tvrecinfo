#!/bin/bash

mediathekViewDir="/media/NAS/MediathekView"

scriptdir=$(cd $(dirname $0); pwd -P)
date=$(date +'%Y-%m-%d__%H_%M_%S')
$scriptdir/update.sh &>> $mediathekViewDir/log/$date.log

