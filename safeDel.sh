#!bin/bash
# safeDel must automatically create the user’s trash can directory
# (~/.trashCan) if it does not already exist.


if [ -d "$~/trashCan" ]; then
  # Control will enter here if $DIRECTORY already exists
  ls -al
else
  # create the folder in the system
  cd
  mkdir .trashCan/
  if [[ -f $1 ]]; then
    echo "$1 is a file"
  fi
fi
