#!/bin/bash

#Uses https://github.com/cadivus/cli-text-tool

source_dir="/media/recording-hdds/hdd1/recordings/Seriensuche/The_Big_Bang_Theory/The_Big_Bang_Theory"
target_dir='/media/recording-hdds/hdd1/recordings/Seriensuche/The_Big_Bang_Theory/The_Big_Bang_Theory__sortiert'

database='https://www.eplists.de/eplist.cgi?action=show&file=The%20Big%20Bang%20Theory'
serie='The_Big_Bang_Theory'

find $source_dir -maxdepth 1 | sed 's#.*/##' | while read var; do
    echo "$var"
    var_mod=$(terminal-text-tool input="$var" selectsplit0=',_Sitcom' remove='#3F')
    echo "$var_mod"
    
    indb=$(tvrecinfo "$database" --title="$var_mod" --in-database)
    echo $indb
    
    if [ "$indb" = "True" ]; then
       staffel=$(tvrecinfo "$database" --title="$var_mod" --get-row="SE")
       
       staffel_ep=$(tvrecinfo "$database" --title="$var_mod" --get-row="EP")
       staffel_ep=$(printf "%02d\n" $staffel_ep)
       
       ep=$(tvrecinfo "$database" --title="$var_mod" --get-row="No.")
       ep=$(printf "%03d\n" $ep)
       
       folder="Staffel$staffel"
       desti="${folder}/${ep}_${staffel_ep}__${serie}_-_$var_mod"
       echo ''
       echo "mkdir -p $target_dir/$folder"
       mkdir -p $target_dir/$folder
       
       echo "mkdir -p $target_dir/$desti"
       mkdir -p "$target_dir/$desti"
       
       echo "mv -v ${var}/* $target_dir/$desti/"
       mv -v "$var"/* "$target_dir/$desti/"
       
       echo "rm -d $var"
       rm -d "$var"       
    fi
    
    echo ''
    echo ''
    echo ''
    echo ''
done

