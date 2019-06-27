#!/bin/bash

working_directory="/media/NAS/MediathekView/SOKO_Leipzig"
target_folder="/media/NAS/Filme/SOKO/SOKO_Leipzig"
serie='SOKO_Leipzig'
database='https://www.eplists.de/eplist.cgi?action=show&file=SOKO%20Leipzig'

slash='/'
strich='_'
sep='_-_'

rm $working_directory/*Hörfassung*.mp4

find $working_directory/*.mp4 | while read line; do 
  filename=$(basename -- "$line")
  echo $filename; 
  
  #extract episode-name
  var_mod=$(terminal-text-tool input="$filename" selectsplit2='___' remove='.mp4')
  indb=$(tvrecinfo "$database" --title="$var_mod" --in-database)
    
  if [ "$indb" = "True" ]; then
    #extract series
    staffel=$(tvrecinfo "$database" --title="$var_mod" --get-column="SE")
    
    #extract episode-number
    staffel_ep=$(tvrecinfo "$database" --title="$var_mod" --get-column="EP")
    staffel_ep=$(printf "%02d\n" $staffel_ep)
  
    #Extract eipsode-number in series
    ep=$(tvrecinfo "$database" --title="$var_mod" --get-column="No.")
    ep=$(printf "%03d\n" $ep)

    #target folder
    folder="$target_folder/Staffel$staffel"
    
    #target file
    target="$folder$slash$ep$strich$staffel_ep$strich$strich$serie$sep$var_mod.mp4"
    
    echo $folder
    echo $target
    
    echo "mkdir -p $folder"
    mkdir -p "$folder"
    
    echo "mv -n $line $target"
    mv -n "$line" "$target"

  fi
  echo ''
  echo ''
  echo ''
  echo ''
done
