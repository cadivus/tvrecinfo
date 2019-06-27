#!/bin/bash

scriptdir=$(cd $(dirname $0); pwd -P)

date=$(date +'%Y-%m-%d__%H_%M_%S')

$scriptdir/update.sh &>> /media/NAS/MediathekView/log/$date.log

