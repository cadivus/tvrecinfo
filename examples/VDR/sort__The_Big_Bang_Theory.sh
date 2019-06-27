#!/bin/bash


database='https://www.eplists.de/eplist.cgi?action=show&file=The%20Big%20Bang%20Theory'

source_dir="/media/recording-hdds/hdd1/recordings/Seriensuche/The_Big_Bang_Theory/The_Big_Bang_Theory"
target_dir='/media/recording-hdds/hdd1/recordings/Seriensuche/The_Big_Bang_Theory/The_Big_Bang_Theory__sortiert'

find $source_dir -maxdepth 1 | sed 's#.*/##' | while read var; do
    echo "$var"
    var_mod=$(terminal-text-tool input="$var" selectsplit0=',_Sitcom' remove='#3F')
    echo "$var_mod"
    
    indb=$(tvrecinfo "$database" --title="$var_mod" --in-database)
    echo $indb
    
    if [ "$indb" = "True" ]; then
       slash='/'
       strich='_'
       sep='_-_'
       serie='The_Big_Bang_Theory'
       
       staffel=$(tvrecinfo "$database" --title="$var_mod" --get-row="SE")
       
       staffel_ep=$(tvrecinfo "$database" --title="$var_mod" --get-row="EP")
       staffel_ep=$(printf "%02d\n" $staffel_ep)
       
       ep=$(tvrecinfo "$database" --title="$var_mod" --get-row="No.")
       ep=$(printf "%03d\n" $ep)
       
       folder="Staffel$staffel"
       desti="$folder$slash$ep$strich$staffel_ep$strich$strich$serie$sep$var_mod"
       echo ''
       echo "mkdir -p $target_dir/$folder"
       mkdir -p $target_dir/$folder
       
       sour='/'
       sour="$var$sour"
       
       echo "mkdir -p $target_dir/$desti$slash"
       mkdir -p "$target_dir/$desti$slash"
       
       echo "mv -v $var/* $target_dir/$desti/"
       mv -v "$var"/* "$target_dir/$desti"/
       
       echo "rm -d $var"
       rm -d "$var"
       
    fi
    
    echo ''
    echo ''
    echo ''
    echo ''
done

