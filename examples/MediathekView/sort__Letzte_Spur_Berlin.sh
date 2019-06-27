#!/bin/bash

#Uses https://github.com/cadivus/cli-text-tool

working_directory="/media/NAS/MediathekView/Letzte_Spur_Berlin"
target_folder="/media/NAS/Filme/Letzte_Spur_Berlin"

serie='Letzte_Spur_Berlin'
database='https://www.eplists.de/eplist.cgi?action=show&file=Letzte%20Spur%20Berlin'

rm $working_directory/*Hörfassung*.mp4

find $working_directory/*.mp4 | while read line; do 
  filename=$(basename -- "$line")
  echo $filename; 
  
  #extract episode-name
  var_mod=$(cli-text-tool "$filename" --selectsplit 2 '___' --remove '.mp4')
  
  
  #extract episode-name for second version of filenaming
  if [ $(cli-text-tool "$filename" --contains "ZDF___Letzte_Spur_Berlin___") = "True" ] && [ $(cli-text-tool "$filename" --contains "_-_Staffel_") = "True" ]; then
    var_mod=$(cli-text-tool "$filename" --remove "ZDF___Letzte_Spur_Berlin___" --selectsplit 0 "_-_Staffel_")
  fi
  
  #extract episode-name for second version of filenaming
  if [ $(cli-text-tool "$filename" --contains "ZDF___Letzte_Spur_Berlin___Folge_") = "True" ] && [ $(cli-text-tool "$filename" --contains "_-_Staffel_") = "True" ]; then
    var_mod=$(cli-text-tool "$filename" --remove "ZDF___Letzte_Spur_Berlin___Folge_" --selectsplit 0 "_-_Staffel_" --selectsplit 1 "__")
  fi

  indb=$(tvrecinfo "$database" --title="$var_mod" --in-database)
  echo $var_mod
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
    target="${folder}/${ep}_${staffel_ep}__${serie}_-_$var_mod.mp4"
    
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
