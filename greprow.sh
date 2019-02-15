#!/bin/bash - 
#===============================================================================
#
#          FILE: greprow.sh
# 
#         USAGE: sudo ./greprow.sh 
# 
#   DESCRIPTION: Enter any information that could be contained in your list, this will
#		pull the entire line that is related to that search term and print/append the data
#		to a new file in working directory.
# 
#       OPTIONS: ---
#  REQUIREMENTS: you need to have a .txt file in a location you know
#		
#          BUGS: will not work if you use a space in the search term, also, still creates a file even if script returns an error
#                for no search term found, few others but gotta keep running it over and over yet
#         NOTES: v2.2
#        AUTHOR: @incredincomp
#  ORGANIZATION: 
#       CREATED: 01/08/2019 09:55:54 PM
#      REVISION:  02/15/2019 10:44:00 AM
#===============================================================================


set -o nounset                              # Treat unset variables as an error

print_line () { 
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

clear_white () {
"$(echo -e "${Look_for}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
}

#this is just a weird function that I dont think i need.  at the end tho, part of the switch case calls for a repeat of the
#program functions so hey, why not make it easier on the program and compile it here?
next_Search () {
    set_Path
    what_Find
    grep_Append
    next_Step
}

#set path has been reverted to command line interaction again, youre welcome to myself
set_Path () {
echo " If you would like to define your own path, please press y. Otherwise, if you want this program to break, please press n. "
echo -n "y or n: " 
read answer
case $answer in

            [yY] )
                   read -p "Please type your full file path, starting with a backslash if its absolute. Its more than likely equal to $PWD/names.txt: " inputPath
                   ;;

            [nN] )
                   echo "okay, were going to just use $PWD/log.txt for you."
                   inputPath="$PWD/log.txt"
                   ;;

               * ) 
	           echo "Invalid input"
                   continue
                   ;;
esac
}

#this function collects the variable that is used to search the specified file and stores it as lookFor
what_Find () {  
    echo "	"
    echo -n "What information would you like to find? (Do not use a Space if asking for a name.) "    
        read Look_for
	Look_for2="$(echo -e "${Look_for}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
	if [ -z "$Look_for2" ]; then 
		echo "Sorry! I cant search for null.. Try again"
		echo "/n"
		return
	fi
    print_line
    echo "Looking for $Look_for... Please wait... "
    echo "Search Start Time : " $(date -u)
    print_line
}

grep_Append () {
#I dont know why this works, how or if it even should.  This while statement shows my naivety to bash scripting though.
###DO NOT TOUCH!!!! THIS SHOULDNT WORK, SO THEREFORE ITS PERFECTLY BROKEN AS IS!!!!###

while : 
 do
     grep -i $Look_for2 $inputPath >> $Look_for2.txt 
     if [ $? -eq 0 ] ; then
       echo "	"
       echo "$Look_for found and writing to file, check current directory for $Look_For.txt"
       echo "Search ended at " $(date -u)
       print_line
       break
     else
       echo "	"
       echo "Error, $Look_for not found in specified file."
       print_line
       next_Step
     fi
 done
}

next_Step () {
print_line
echo -n "Would you like to run another search? [y or n]: "
read reFind
print_line
case $reFind in
   [yY] )
       next_Search
       ;;
		     
   [nN] )
       echo "Okay, I hope you found me useful! See you next time!"
      print_line
       exit
       ;;
    
   * ) 
       echo "ERROR. Please press y or n."
       trick_Step
       ;;
esac
}


#This doesnt exist
#Its just my way of tricking bash into doing what I want
trick_Step () {
    next_Step
}	
#once bash finishes reading functions, the initial search is called here.  When getting to next_Step, if user selects yes
#next_Search will be called which is another previously declared function including these same commands.
set_Path
what_Find
grep_Append
next_Step
