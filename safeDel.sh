#!bin/bash
# safeDel must automatically create the user’s trash can directory
# (~/.trashCan) if it does not already exist.

# case 1
# if called with parameter (filename.file) or list of files [filename.file,...]
trashcan = "~/.trashCan"

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
else
   for filename in "$@"
   do
      echo "$filename"
      mv $filename trashcan
   done
fi

