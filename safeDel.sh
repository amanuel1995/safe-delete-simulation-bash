#!bin/bash
# safeDel must automatically create the user’s trash can directory
# (~/.trashCan) if it does not already exist.

# case 1
# if called with parameter (filename.file) or list of files [filename.file,...]

files="$@"

if [ $# -eq 0 ]; then
	echo "No arguments provided"
    	# go to menu mode
    	# TODO here ...
else
	# process the files listed in params. Simulate delete by moving the files to trashcan
   	for filename in "$@"
   	do
		echo "$filename"
      		# watch out for non-existent files before attempting to delete
		if [[ -f $filename ]] || [[ -d $filename ]]; then
			echo "file exists: $filename"
      			mv $filename ~/.trashCan/
		else
			echo "ERROR: You are attempting to delete a file that doesn't exist!"
		fi
   	done
fi
