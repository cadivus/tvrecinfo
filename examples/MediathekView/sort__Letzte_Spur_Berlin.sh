#!/bin/bash

working_directory="/media/NAS/MediathekView/Letzte_Spur_Berlin"
target_folder="/media/NAS/Filme/Letzte_Spur_Berlin"
serie='Letzte_Spur_Berlin'
database='https://www.eplists.de/eplist.cgi?action=show&file=Letzte%20Spur%20Berlin'

slash='/'
strich='_'
sep='_-_'

rm $working_directory/*Hörfassung*.mp4

find $working_directory/*.mp4 | while read line; do 
  filename=$(basename -- "$line")
  echo $filename; 
  
  #extract episode-name
  var_mod=$(terminal-text-tool input="$filename" selectsplit2='___' remove='.mp4')
  
  
  #extract episode-name for second version of filenaming
  if [ $(terminal-text-tool input="$filename" contains="ZDF___Letzte_Spur_Berlin___Folge_") = "True" ] && [ $(terminal-text-tool input="$filename" contains="_-_Staffel_") = "True" ]; then
    var_mod=$(terminal-text-tool input="$filename" remove="ZDF___Letzte_Spur_Berlin___Folge_" selectsplit0="_-_Staffel_" selectsplit1="__")
  fi
  
  #extract episode-name for second version of filenaming
  if [ $(terminal-text-tool input="$filename" contains="ZDF___Letzte_Spur_Berlin___") = "True" ] && [ $(terminal-text-tool input="$filename" contains="_-_Staffel_") = "True" ]; then
    var_mod=$(terminal-text-tool input="$filename" remove="ZDF___Letzte_Spur_Berlin___" selectsplit0="_-_Staffel_")
  fi

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
