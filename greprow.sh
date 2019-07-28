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
#         NOTES: v2.03
#        AUTHOR: @incredincomp
#  ORGANIZATION: 
#       CREATED: 01/08/2019 09:55:54
#      REVISION:  07/28/2019 00:27:00
#===============================================================================

clear

PROGNAME=$(basename $0)

print_line () {
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

set -o nounset                              # Treat unset variables as an error
set -e

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
print_line
print_line
base64 -d <<<"ICAsLS0tLS4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLC0uLS0tLS4gICAgICAgICAgICAgICAgICAgICAgICAgICAKIC8gICAvICAgXCAgICAgICAgICAgICAgICAgICAsLS4tLS0tLiAgXCAgICAvICBcICAgICAgICAgICAgICAgICAgICAgICAgICAKfCAgIDogICAgIDogICBfXyAgLC0uICAgICAgICBcICAgIC8gIFwgOyAgIDogICAgXCAgICwtLS0uICAgICAgICAgICAuLS0tLiAKLiAgIHwgIDsuIC8gLCcgLCcvIC98ICAgICAgICB8ICAgOiAgICB8fCAgIHwgLlwgOiAgJyAgICwnXCAgICAgICAgIC8uIC4vfCAKLiAgIDsgLy0tYCAgJyAgfCB8JyB8ICwtLS0uICB8ICAgfCAuXCA6LiAgIDogfDogfCAvICAgLyAgIHwgICAgIC4tJy0uICcgfCAKOyAgIHwgOyAgX18gfCAgfCAgICwnLyAgICAgXCAuICAgOiB8OiB8fCAgIHwgIFwgOi4gICA7ICwuIDogICAgL19fXy8gXDogfCAKfCAgIDogfC4nIC4nJyAgOiAgLyAvICAgIC8gIHx8ICAgfCAgXCA6fCAgIDogLiAgLycgICB8IHw6IDogLi0nLi4gJyAgICcgLiAKLiAgIHwgJ18uJyA6fCAgfCAnIC4gICAgJyAvIHx8ICAgOiAuICB8OyAgIHwgfCAgXCcgICB8IC47IDovX19fLyBcOiAgICAgJyAKJyAgIDsgOiBcICB8OyAgOiB8ICcgICA7ICAgL3w6ICAgICB8YC0nfCAgIHwgO1wgIFwgICA6ICAgIHwuICAgXCAgJyAuXCAgICAKJyAgIHwgJy8gIC4nfCAgLCA7ICcgICB8ICAvIHw6ICAgOiA6ICAgOiAgICcgfCBcLidcICAgXCAgLyAgXCAgIFwgICAnIFwgfCAKfCAgIDogICAgLyAgIC0tLScgIHwgICA6ICAgIHx8ICAgfCA6ICAgOiAgIDogOi0nICAgYC0tLS0nICAgIFwgICBcICB8LS0iICAKIFwgICBcIC4nICAgICAgICAgICBcICAgXCAgLyBgLS0tJy58ICAgfCAgIHwuJyAgICAgICAgICAgICAgICBcICAgXCB8ICAgICAKICBgLS0tYCAgICAgICAgICAgICAgYC0tLS0nICAgIGAtLS1gICAgYC0tLScgICAgICAgICAgICAgICAgICAgJy0tLSIgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA="
echo " "
base64 -d <<<"ICBTY3JpcHQgY3JlYXRlZCBhbmQgbWFpbnRhaW5lZCBieSBASW5jcmVkSW5jb21wIG9uIGh0dHBzOi8vZ2l0aHViLmNvbS9pbmNyZWRpbmNvbXAvZ3JlcHJvdy8KICBDb21lIGFuZCBqb2luIHRoZSBjb252ZXJzYXRpb24gYW5kIGhlbHAgbWFrZSB0aGlzIHNjcmlwdCBiZXR0ZXIgZm9yIGFsbCBvZiB1cwogIEZpbGUgaXNzdWVzIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbmNyZWRpbmNvbXAvZ3JlcHJvdy9pc3N1ZXMKICBTcGVjaWFsIFRoYW5rcyB0byBAVmVub200MDQgZm9yIHRoZWlyIGNvbnRyaWJ1dGlvbnMgdG8gdGhlIGJhc2UgcHJvamVjdCE="
echo " "
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
echo "If you would like to define your own path, please press y. For testing, press n. "
echo -n "y or n: "
read -r answer
case $answer in
            [yY] )
                   echo "Please type your full file path, starting with a backslash if its absolute."
		   read -r -e -p "Its more than likely equal to $PWD/log.test: " inputPath
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
    print_line
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
       print_Content
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
echo -n "Would you like to see the file you just created? This will output the file contents to the screen here. [yY or nN]: "
read -r print_Out
print_line
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

get_ip () {
echo "You are about to cut all data from the file you just made and convert in into a list of IP's"
echo -n "Is that what you want? [yY] or [nN]: "
read -r d_ans
case $d_ans in
   [yY] )
   	echo "Check the current directory for a file name IPs-$Look_for2.txt"
	awk '{print $1}' "$PWD/$Look_for2.txt" >> "IPs-$Look_for2.txt"
	;;
   [nN] )
        return
	;;
      * )
        return
	;;
esac
}
next_Step () {
print_line
echo "So far, the only extras that you can complete is to create an ip only list from your last selection."
echo -n "Sound good? [yY] or [nN]:  "
read -r next_ans
case $next_ans in
   [yY] )
       get_ip
       last_Step
       ;;
   [nN] )
       return
       ;;
      * )
       return
       ;;
esac
}

# ask if you would like to restart the program for another search
last_Step () {
print_line
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
	exit
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
