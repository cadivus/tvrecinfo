#!/bin/bash

working_directory="/media/NAS/MediathekView/Tatort"
target_folder="/media/NAS/Filme/Tatort"
serie='Tatort'
database='https://www.eplists.de/eplist.cgi?action=show&file=Tatort'

slash='/'
strich='_'
sep='_-_'

rm $working_directory/*Hörfassung*.mp4
rm $working_directory/*Audiodeskription*.mp4
rm $working_directory/*\(AD\)___*.mp4

find $working_directory/*.mp4 | while read line; do 
  filename=$(basename -- "$line")
  echo $filename; 
  
  #extract episode-name
  filename_mod=$(terminal-text-tool input="$filename" remove='_(ab_12_Jahre)')
  filename_mod=$(terminal-text-tool input="$filename_mod" remove='_(FSK_12)')
  
  var_mod=$(terminal-text-tool input="$filename_mod" selectsplit2='___' remove='Tatort_-_' remove='Tatort__')
  indb=$(tvrecinfo "$database" --title="$var_mod" --in-database)
    
  if [ "$indb" = "True" ]; then
    #extract series
    ermittler=$(tvrecinfo "$database" --title="$var_mod" --get-column="Ermittler")
    ermittler=$(terminal-text-tool input="$ermittler" replacespace replacespecial)
    ort=$(tvrecinfo "$database" --title="$var_mod" --get-column="Ort")
    ort=$(terminal-text-tool input="$ort" replacespace replacespecial)
    
    var_mod=$(terminal-text-tool input="$var_mod" replacespace replacespecial)
    
    #Extract eipsode-number in series
    ep=$(tvrecinfo "$database" --title="$var_mod" --get-column="No.")
    ep=$(printf "%04d\n" $ep)

    #target folder
    folder="$target_folder/$ort$strich$strich$ermittler"
    
    #target file
    target="$folder$slash$ep$strich$strich$serie$strich$ort$sep$var_mod.mp4"
    
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
