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
#         NOTES: v3.0.0
#        AUTHOR: @incredincomp
#  ORGANIZATION: 
#       CREATED: 01/08/2019 09:55:54
#      REVISION:  07/28/2019 23:09:00
#===============================================================================


clear
set -o nounset                              # Treat unset variables as an error
set -e

## Global

print_line () {
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

Banner () {
	base64 -d <<<"ICAsLS0tLS4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLC0uLS0tLS4gICAgICAgICAgICAgICAgICAgICAgICAgICAKIC8gICAvICAgXCAgICAgICAgICAgICAgICAgICAsLS4tLS0tLiAgXCAgICAvICBcICAgICAgICAgICAgICAgICAgICAgICAgICAKfCAgIDogICAgIDogICBfXyAgLC0uICAgICAgICBcICAgIC8gIFwgOyAgIDogICAgXCAgICwtLS0uICAgICAgICAgICAuLS0tLiAKLiAgIHwgIDsuIC8gLCcgLCcvIC98ICAgICAgICB8ICAgOiAgICB8fCAgIHwgLlwgOiAgJyAgICwnXCAgICAgICAgIC8uIC4vfCAKLiAgIDsgLy0tYCAgJyAgfCB8JyB8ICwtLS0uICB8ICAgfCAuXCA6LiAgIDogfDogfCAvICAgLyAgIHwgICAgIC4tJy0uICcgfCAKOyAgIHwgOyAgX18gfCAgfCAgICwnLyAgICAgXCAuICAgOiB8OiB8fCAgIHwgIFwgOi4gICA7ICwuIDogICAgL19fXy8gXDogfCAKfCAgIDogfC4nIC4nJyAgOiAgLyAvICAgIC8gIHx8ICAgfCAgXCA6fCAgIDogLiAgLycgICB8IHw6IDogLi0nLi4gJyAgICcgLiAKLiAgIHwgJ18uJyA6fCAgfCAnIC4gICAgJyAvIHx8ICAgOiAuICB8OyAgIHwgfCAgXCcgICB8IC47IDovX19fLyBcOiAgICAgJyAKJyAgIDsgOiBcICB8OyAgOiB8ICcgICA7ICAgL3w6ICAgICB8YC0nfCAgIHwgO1wgIFwgICA6ICAgIHwuICAgXCAgJyAuXCAgICAKJyAgIHwgJy8gIC4nfCAgLCA7ICcgICB8ICAvIHw6ICAgOiA6ICAgOiAgICcgfCBcLidcICAgXCAgLyAgXCAgIFwgICAnIFwgfCAKfCAgIDogICAgLyAgIC0tLScgIHwgICA6ICAgIHx8ICAgfCA6ICAgOiAgIDogOi0nICAgYC0tLS0nICAgIFwgICBcICB8LS0iICAKIFwgICBcIC4nICAgICAgICAgICBcICAgXCAgLyBgLS0tJy58ICAgfCAgIHwuJyAgICAgICAgICAgICAgICBcICAgXCB8ICAgICAKICBgLS0tYCAgICAgICAgICAgICAgYC0tLS0nICAgIGAtLS1gICAgYC0tLScgICAgICAgICAgICAgICAgICAgJy0tLSIgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA="

}

## Opening title and credits
opener () {
print_line
print_line
Banner
echo " "
base64 -d <<<"ICBTY3JpcHQgY3JlYXRlZCBhbmQgbWFpbnRhaW5lZCBieSBASW5jcmVkSW5jb21wIG9uIGh0dHBzOi8vZ2l0aHViLmNvbS9pbmNyZWRpbmNvbXAvZ3JlcHJvdy8KICBDb21lIGFuZCBqb2luIHRoZSBjb252ZXJzYXRpb24gYW5kIGhlbHAgbWFrZSB0aGlzIHNjcmlwdCBiZXR0ZXIgZm9yIGFsbCBvZiB1cwogIEZpbGUgaXNzdWVzIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNvbS9pbmNyZWRpbmNvbXAvZ3JlcHJvdy9pc3N1ZXMKICBTcGVjaWFsIFRoYW5rcyB0byBAVmVub200MDQgZm9yIHRoZWlyIGNvbnRyaWJ1dGlvbnMgdG8gdGhlIGJhc2UgcHJvamVjdCE="
echo " "
print_line
print_line
}

## Menus

Opening_Menu () {
opener
PS3='Please enter your choice: '
options=("Set a Path" "Delete the .txt Files")
select opt in "${options[@]}" "Quit";
do
    case $opt in
        "Set a Path")
                set_Path
                what_Find
                grep_Append
                next_Step
                ;;
        "Delete the .txt Files")
                delete_Tests
                ;;
        "Quit")
                last_Step
                ;;
             *) 
                echo "Invalid option. Try another one."
                ;;
    esac
done
}

next_Step () {
	print_line
	PS3='What would you like to do now? '
	options=("Try a New Search" "Print the File" "Manipulate the File")
	select opt in "${options[@]}" "Quit";
	do
            case $opt in
                    "Try a New Search")
                            set_Path
                            what_Find
                            grep_Append
                            ;;
                    "Print the File")
                            print_Content
                            ;;
                    "Manipulate the File")
                            PS3='Which Manipulation? '
                            options=("Get Unique IPs" "Delete .txt Files")
                            select opt in "${options[@]}" "Back";
                            do
            	                case $opt in
            		                "Get Unique IPs")
                                                get_ip
                                                ;;
                                        "Delete .txt Files")
                                                delete_Tests
                                                ;;
                                        "Back")
                                                break
                                                ;;
                                        *) 
                                                echo "Invalid option. Try another one."
                                                continue
                                                ;;
                                esac
                            done
                            ;;
                    "Quit")
                            last_Step
                            ;;
                    *) 
                            echo "Invalid option. Try another one."
                            continue
                            ;;
            esac
        done
}

## Main
# set path has been reverted to command line interaction again, youre welcome to myself
set_Path () {
    echo "Please type your full file path, starting with a backslash if its absolute."
    read -r -e -p "Its more than likely equal to $PWD/log.test: " inputPath
}
# this function collects the variable that is used to search the specified file and stores it as Look_for
what_Find () {  
    echo
    print_line
    echo -n "What information would you like to find? (Do not use a Space if asking for a name.) "
    read -r Look_for
    Look_for2=$(echo -e "${Look_for}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    echo 
    echo "Looking for $Look_for2... Please wait... Search started at:"
    date -u
    Banner
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
       break
     else
       echo
       echo "Error, $Look_for not found in specified file."
       print_line
       next_Step
     fi
 done
}

## File Manipulation

delete_Tests () {
        rm ./*.txt
        echo "Files deleted. Take care."
}

get_ip () {
        echo "Check the current directory for a file name IPs-$Look_for2.txt"
        awk '{print $1}' "$PWD/$Look_for2.txt" | uniq -u > "IPs-$Look_for2.txt"
}

print_Content () {
    print_File
    next_Step
}

print_File () {
  FILE=$Look_for2.txt
cat "$FILE"
}

## Compilation Functions and Call Backs
next_Search () {
    set_Path
    what_Find
    grep_Append
    next_Step
}

# This doesnt exist
# Its just my way of tricking bash into doing what I want
trick_Step () {
    next_Step
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

Opening_Menu
