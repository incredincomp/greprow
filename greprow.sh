#!/bin/bash -
#===============================================================================
#
#          FILE: greprow.sh
#
#        USAGE: sudo ./greprow.sh
#
#   DESCRIPTION:
#		Enter any information that could be contained in your list, this will
#		pull the entire line that is related to that search term and print/append the data
#		to a new file with the name of the search issued.  needs format work,
#		much apologies
# 
#       OPTIONS: ---
#  REQUIREMENTS: you need to have a .txt file in a location you know
#		
#          BUGS: will not work if you use a space in the search term, also, still creates a file even if script returns an error
#                for no search term found, few others but gotta keep running it over and over yet
#         NOTES: v2.02
#        AUTHOR: @incredincomp
#  ORGANIZATION: 
#       CREATED: 01/08/2019 09:55:54 PM
#      REVISION:  07/26/2019 22:35:00 AM
#===============================================================================

PROGNAME=$(basename $0)

print_line () {
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

set -o nounset                              # Treat unset variables as an error

# setting up getopt function to allow for runtime commandline arguments
while getopts "abcd" option; do
	case ${option} in
		a )
			echo "you choose an apache log"
			;;
		b )
			echo "you choose an nginx log"
			;;
		c )
			echo "you choose an access log"
			;;
		d )
			echo "you choose a grepable nmap file"
			;;
		\? )
			echo "you need to choose an option"
			;;
	esac
done

next_Search () {
    set_Path
    what_Find
    grep_Append
    next_Step
}

# This is the start of an attempt at option handling
file_Options () {
# I asked -- I wonder if i can nest a function inside of a function
# someone said -- It is even possible to nest a function within another function, although this is not very useful.
# then I said -- but watch how useful this will be someday
	apache () {
	}
	nginx () {
	}
	access () {
	}
	nmap () {
	}
}
# set path has been reverted to command line interaction again, youre welcome to myself
set_Path () {
echo " If you would like to define your own path, please press y. Otherwise, if you want this program to break, please press n. "
echo -n " y or n: "
read -r answer
case $answer in
            [yY] )
                   echo -n "Please type your full file path, starting with a backslash if its absolute. Its more than likely equal to $PWD/names.txt: "
		   read -r inputPath
                   ;;

            [nN] )
                   echo "okay, were going to just use $PWD/log.txt for you."
                   inputPath="$PWD/log.test"
                   ;;

               * ) 
	           echo "Invalid input"
                   return
                   ;;
esac
}

# this function collects the variable that is used to search the specified file and stores it as Look_for
what_Find () {  
    echo
    echo -n "What information would you like to find? (Do not use a Space if asking for a name.) "
    read -r Look_for
    Look_for2=$(echo -e "${Look_for}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    echo 
    echo "Looking for $Look_for2... Please wait... "
    echo "Search Start Time : " | date -u
    print_line
}

grep_Append () {
# I dont know why this works, how or if it even should.  This while statement 
# shows my naivety to bash scripting though.
# DO NOT TOUCH!!!! THIS SHOULDNT WORK, SO THEREFORE ITS PERFECTLY BROKEN AS IS!

while :
 do
     grep -i "$Look_for2" "$inputPath" >> "$Look_for2.txt"
     if [ $? -eq 0 ] ; then
       echo
       echo "$Look_for found and writing to file, check current directory for $Look_for.txt"
       echo "Search ended at " "$(date -u)"
       print_line
       break
     else
       echo
       echo "Error, $Look_for not found in specified file."
       print_line
       next_Step
     fi
 done
}

# This doesnt exist
# Its just my way of tricking bash into doing what I want
trick_Step () {
    next_Step
}

print_Content () {
echo -n "would you like to see the file you just created? This will output the file contents to the screen here. [yY or nN]: "
read -r print_Out
case $print_Out in
	[yY] )
		print_File
		return
		;;
	[nN] )
		return
		;;
	* )
		return
		;;
esac
}

print_File () {
	FILE=$Look_for2.txt
cat "$FILE"
}

# this function is the final slide of the actual program. this will just ask if you would
# like to restart the program for another search
next_Step () {
print_Content
echo -n "Would you like to run another search? [y or n]: "
read -r reFind
print_line
case $reFind in
   [yY] )
       next_Search
       ;;
   [nN] )
       echo "Okay, I hope you found me useful! See you next time!"
       print_line
       delete_Tests
       exit
       ;;
   *)
       echo " ERROR! Please press y or n. "
       trick_Step
       ;;
esac
}

delete_Tests () {
echo -n "Would you like to delete the test files (CAUTION: will delete all .txt files in current directory)? [y or n]: "
read -r delete
case $delete in
   [yY] )
	rm ./*.txt
	echo "Files deleted. Take care."
	;;
   [nN] )
	next_Step
	;;
esac
}

# once bash finishes reading functions, the initial search is called here.
# When getting to next_Step, if user selects yes next_Search will be called which is another
# previously declared function including these same commands.
set_Path
what_Find
grep_Append
next_Step
