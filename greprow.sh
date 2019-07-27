#!/bin/bash -
#===============================================================================
#
#          FILE: greprow.sh
#
#        USAGE: ./greprow.sh
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

clear

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

opener () {
echo " "
print_line
print_line
base64 -d <<<"CgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICwtLS0tLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAsLS4tLS0tLiAgICAgICAgICAgICAgICAgICAgICAgICAgIAogLyAgIC8gICBcICAgICAgICAgICAgICAgICAgICwtLi0tLS0uICBcICAgIC8gIFwgICAgICAgICAgICAgICAgICAgICAgICAgIAp8ICAgOiAgICAgOiAgIF9fICAsLS4gICAgICAgIFwgICAgLyAgXCA7ICAgOiAgICBcICAgLC0tLS4gICAgICAgICAgIC4tLS0uIAouICAgfCAgOy4gLyAsJyAsJy8gL3wgICAgICAgIHwgICA6ICAgIHx8ICAgfCAuXCA6ICAnICAgLCdcICAgICAgICAgLy4gLi98IAouICAgOyAvLS1gICAnICB8IHwnIHwgLC0tLS4gIHwgICB8IC5cIDouICAgOiB8OiB8IC8gICAvICAgfCAgICAgLi0nLS4gJyB8IAo7ICAgfCA7ICBfXyB8ICB8ICAgLCcvICAgICBcIC4gICA6IHw6IHx8ICAgfCAgXCA6LiAgIDsgLC4gOiAgICAvX19fLyBcOiB8IAp8ICAgOiB8LicgLicnICA6ICAvIC8gICAgLyAgfHwgICB8ICBcIDp8ICAgOiAuICAvJyAgIHwgfDogOiAuLScuLiAnICAgJyAuIAouICAgfCAnXy4nIDp8ICB8ICcgLiAgICAnIC8gfHwgICA6IC4gIHw7ICAgfCB8ICBcJyAgIHwgLjsgOi9fX18vIFw6ICAgICAnIAonICAgOyA6IFwgIHw7ICA6IHwgJyAgIDsgICAvfDogICAgIHxgLSd8ICAgfCA7XCAgXCAgIDogICAgfC4gICBcICAnIC5cICAgIAonICAgfCAnLyAgLid8ICAsIDsgJyAgIHwgIC8gfDogICA6IDogICA6ICAgJyB8IFwuJ1wgICBcICAvICBcICAgXCAgICcgXCB8IAp8ICAgOiAgICAvICAgLS0tJyAgfCAgIDogICAgfHwgICB8IDogICA6ICAgOiA6LScgICBgLS0tLScgICAgXCAgIFwgIHwtLSIgIAogXCAgIFwgLicgICAgICAgICAgIFwgICBcICAvIGAtLS0nLnwgICB8ICAgfC4nICAgICAgICAgICAgICAgIFwgICBcIHwgICAgIAogIGAtLS1gICAgICAgICAgICAgICBgLS0tLScgICAgYC0tLWAgICBgLS0tJyAgICAgICAgICAgICAgICAgICAnLS0tIiAgICAgIAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAoK"
echo "  Script created and maintained by @IncredIncomp on https://github.com/incredincomp/greprow/"
echo "  Come and join the conversation and help make this script better for all of us"
echo "  File issues here: https://github.com/incredincomp/greprow/issues"
echo "  Special Thanks to @Venom404 for their contributions to the base project!"
print_line
print_line
}

next_Search () {
    set_Path
    what_Find
    grep_Append
    next_Step
}

# This is the start of an attempt at option handling


# set path has been reverted to command line interaction again, youre welcome to myself
set_Path () {
echo " If you would like to define your own path, please press y. For testing, press n. "
echo -n " y or n: "
read -r answer
case $answer in
            [yY] )
                   echo "Please type your full file path, starting with a backslash if its absolute."
		   echo -n "Its more than likely equal to $PWD/log.test: "
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

# ask if you would like to restart the program for another search
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
opener
set_Path
what_Find
grep_Append
next_Step
