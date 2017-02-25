#! /bin/bash

while read line
do
  if [[ "$line" =~ "MODIFY" ]]
  then
    file=${line// /}
	file=${file/MODIFY/}
	if [ ${line: -5} == ".java" ]
    then
      echo -e "\njavac $file"
	  javac $file
    fi
  elif [[ "$line" =~ "CLOSE_WRITE,CLOSE" ]]
  then
    file=${line// /}
	file=${file/CLOSE_WRITE,CLOSE/}
    if [ ${file: -6} == ".class" ]
    then
	  echo -e "java $file ... \n"
      file=${file/"$1"/}
	  CLASS=${file/\.class/}
	  (cd $1; java $CLASS)
    fi
  fi
done < <(inotifywait -m "$1")
