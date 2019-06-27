#!/bin/bash

#Uses https://github.com/cadivus/cli-text-tool

working_directory="/media/NAS/MediathekView/Tatort"
target_folder="/media/NAS/Filme/Tatort"

serie='Tatort'
database='https://www.eplists.de/eplist.cgi?action=show&file=Tatort'

rm $working_directory/*Hörfassung*.mp4
rm $working_directory/*Audiodeskription*.mp4
rm $working_directory/*\(AD\)___*.mp4

find $working_directory/*.mp4 | while read line; do 
  filename=$(basename -- "$line")
  echo $filename; 
  
  #extract episode-name
  filename_mod=$(cli-text-tool "$filename" --remove='_(ab_12_Jahre)')
  filename_mod=$(cli-text-tool "$filename_mod" --remove='_(FSK_12)')
  
  var_mod=$(cli-text-tool "$filename_mod" --selectsplit 2 '___' --remove='Tatort_-_' --remove='Tatort__')
  indb=$(tvrecinfo "$database" --title="$var_mod" --in-database)
    
  if [ "$indb" = "True" ]; then
    #extract series
    ermittler=$(tvrecinfo "$database" --title="$var_mod" --get-column="Ermittler")
    ermittler=$(cli-text-tool "$ermittler" --replacespace --replacespecial)
    ort=$(tvrecinfo "$database" --title="$var_mod" --get-column="Ort")
    ort=$(cli-text-tool "$ort" --replacespace --replacespecial)
    
    var_mod=$(cli-text-tool "$var_mod" --replacespace --replacespecial)
    
    #Extract eipsode-number in series
    ep=$(tvrecinfo "$database" --title="$var_mod" --get-column="No.")
    ep=$(printf "%04d\n" $ep)

    #target folder
    folder="$target_folder/${ort}__$ermittler"
    
    #target file
    target="${folder}/${ep}__${serie}_${ort}_-_$var_mod.mp4"
    
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
