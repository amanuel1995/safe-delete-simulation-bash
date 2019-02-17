#!bin/bash

# if the simulated trashCan doesn't exist, create it automatically
if [ ! -d ~/.trashCan/ ]; then
	echo "the simulated trashCan dir is being created ..."
	mkdir ~/.trashCan/
fi

# case 1
# called without any arguments - display a menu

if [ $# -eq 0 ]; then
	echo "Please make a choice: "

	options=("list" "recover" "delete" "total" "monitor" "kill")
	select opt in "${options[@]}"
	do
		case $opt in
			"list")
			ls -ls --file-type
			break;;
			
			"recover")
			echo "type the filename you want to recover:"
			break;;
			
			"delete")
			echo "interactively deleting contents of trash:"
			rm -ri ~/.trashCan/
			break;;
			
			"total")
			du -s -- ~/.trashCan
			break;;
			
			"monitor")
			echo "test"
			break;;
			
			"kill")
			echo "test 2"
			break;;
			*) echo "invalid option";;
		esac
	done

# if script is called with parameter (filename.file) or list of files [filename.file, filename2.file, ...]
elif [[ -f $1 ]]; then
	# process the files listed in params. Simulate delete by moving the files to trashcan
   	for filename in "$@"
   	do
		echo "$filename"
      		# watch out for non-existent files before attempting to delete
		if [[ -f $filename ]] || [[ -d $filename ]]; then
			echo "Found the file with file name : $filename"
      			mv $filename ~/.trashCan/
			echo "Deleted the file successfully."
		else
			echo "ERROR: You are attempting to delete a file that doesn't exist!"
		fi
   	done

else	
	# case 2 when script is called with a flag
	# go to option mode
	while getopts ":ldtmkh" option_flag; do
		case ${option_flag} in
			l ) # process option l : output a list the trashCan directory;
			echo "option l selected"
			ls -l ~/.trashCan/
			;;
			d ) # process option d : interactively delete the contents of the trashCan directory
			echo "Option d selected"
			rm -ri ~/.trashCan/
			;;
			t ) # process option t : display total usage in bytes of the trashCan directory
			echo "Option t selected"
			du -s -- ~/.trashCan
			;;	
			m ) # process option m : start monitor script process
			echo "Option m selected"
			;;
			k ) # process option k : stop monitor script process
			echo "Option m selected"
			;;
			h ) # process h
			echo "Usage: Utility safeDel simulates the removal of one or more files by moving them to the user’s trash can directory. 
Typical usage to do this is as follows: safeDel.sh file [file ...]"
			;;
			\? ) echo "Usage: safeDel [-l] [-r] [-d] [-t] [-m] [-k]"
			;;
		esac
	done

	# if the flag is -r (recover a deleted file, further specify the filename)
	while getopts ":r:" opt; do
		case ${opt} in
			r )
			target=$OPTARG
			;;
			\? )
			echo "Invalid option: $OPTARG" 1>&2
			;;
			: )
			echo "Invalid option: $OPTARG requires an argument" 1>&2
			;;
		esac
	done
	shift $((OPTIND -1))
fi
