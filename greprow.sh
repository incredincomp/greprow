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
#  REQUIREMENTS: you need to have a file in a location you know
#
#          BUGS: few but gotta keep running it over and over yet
#         NOTES: v3.0.2-1
#        AUTHOR: @incredincomp
#  ORGANIZATION:
#       CREATED: 01/08/2019 09:55:54
#      REVISION: 09/16/2019 14:41:00
#     LICENSING:  GNU GENERAL PUBLIC LICENSE V3
#                 Copyright (C) 2019  @incredincomp
#
#                 This program is free software: you can redistribute it and/or modify
#                 it under the terms of the GNU General Public License as published by
#                 the Free Software Foundation, either version 3 of the License, or
#                 (at your option) any later version.
#
#                 This program is distributed in the hope that it will be useful,
#                 but WITHOUT ANY WARRANTY; without even the implied warranty of
#                 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#                 GNU General Public License for more details.
#
#                 You should have received a copy of the GNU General Public License
#                 along with this program.  If not, see <https://www.gnu.org/licenses/>.
#===============================================================================
clear
set -o nounset                              # Treat unset variables as an error
set -e
# Uncomment to print script in console for debug
#set -xv
## Global Graphical Objects
print_line () {
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}
Banner () {
	base64 -d <<<"ICAsLS0tLS4uICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLC0uLS0tLS4gICAgICAgICAgICAgICAgICAgICAgICAgICAKIC8gICAvICAgXCAgICAgICAgICAgICAgICAgICAsLS4tLS0tLiAgXCAgICAvICBcICAgICAgICAgICAgICAgICAgICAgICAgICAKfCAgIDogICAgIDogICBfXyAgLC0uICAgICAgICBcICAgIC8gIFwgOyAgIDogICAgXCAgICwtLS0uICAgICAgICAgICAuLS0tLiAKLiAgIHwgIDsuIC8gLCcgLCcvIC98ICAgICAgICB8ICAgOiAgICB8fCAgIHwgLlwgOiAgJyAgICwnXCAgICAgICAgIC8uIC4vfCAKLiAgIDsgLy0tYCAgJyAgfCB8JyB8ICwtLS0uICB8ICAgfCAuXCA6LiAgIDogfDogfCAvICAgLyAgIHwgICAgIC4tJy0uICcgfCAKOyAgIHwgOyAgX18gfCAgfCAgICwnLyAgICAgXCAuICAgOiB8OiB8fCAgIHwgIFwgOi4gICA7ICwuIDogICAgL19fXy8gXDogfCAKfCAgIDogfC4nIC4nJyAgOiAgLyAvICAgIC8gIHx8ICAgfCAgXCA6fCAgIDogLiAgLycgICB8IHw6IDogLi0nLi4gJyAgICcgLiAKLiAgIHwgJ18uJyA6fCAgfCAnIC4gICAgJyAvIHx8ICAgOiAuICB8OyAgIHwgfCAgXCcgICB8IC47IDovX19fLyBcOiAgICAgJyAKJyAgIDsgOiBcICB8OyAgOiB8ICcgICA7ICAgL3w6ICAgICB8YC0nfCAgIHwgO1wgIFwgICA6ICAgIHwuICAgXCAgJyAuXCAgICAKJyAgIHwgJy8gIC4nfCAgLCA7ICcgICB8ICAvIHw6ICAgOiA6ICAgOiAgICcgfCBcLidcICAgXCAgLyAgXCAgIFwgICAnIFwgfCAKfCAgIDogICAgLyAgIC0tLScgIHwgICA6ICAgIHx8ICAgfCA6ICAgOiAgIDogOi0nICAgYC0tLS0nICAgIFwgICBcICB8LS0iICAKIFwgICBcIC4nICAgICAgICAgICBcICAgXCAgLyBgLS0tJy58ICAgfCAgIHwuJyAgICAgICAgICAgICAgICBcICAgXCB8ICAgICAKICBgLS0tYCAgICAgICAgICAgICAgYC0tLS0nICAgIGAtLS1gICAgYC0tLScgICAgICAgICAgICAgICAgICAgJy0tLSIgICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA="
}
Credits () {
	base64 -d <<<"U2NyaXB0IGNyZWF0ZWQgYW5kIG1haW50YWluZWQgYnkgQGluY3JlZGluY29tcCBvbiBodHRwczovL2dpdGh1Yi5jb20vaW5jcmVkaW5jb21wL2dyZXByb3cvCkNvbWUgYW5kIGpvaW4gdGhlIGNvbnZlcnNhdGlvbiAobWFpbmx5IGZpbGUgaXNzdWVzIGFuZCBmb3JrKQpGaWxlIGlzc3VlcyBoZXJlOiBodHRwczovL2dpdGh1Yi5jb20vaW5jcmVkaW5jb21wL2dyZXByb3cvaXNzdWVzClNwZWNpYWwgVGhhbmtzIHRvIEBWZW5vbTQwNCBmb3IgdGhlaXIgY29udHJpYnV0aW9ucyB0byB0aGUgYmFzZSBwcm9qZWN0IQpHcmVwUm93IENvcHlyaWdodCAoQykgMjAxOSAgQGluY3JlZGluY29tcApUaGlzIHByb2dyYW0gY29tZXMgd2l0aCBBQlNPTFVURUxZIE5PIFdBUlJBTlRZLgpUaGlzIGlzIGZyZWUgc29mdHdhcmUsIGFuZCB5b3UgYXJlIHdlbGNvbWUgdG8gcmVkaXN0cmlidXRlIGl0IHVuZGVyIGNlcnRhaW4gY29uZGl0aW9ucy4="
}
## Opening title and credits
opener () {
print_line
Banner
echo " "
Credits
echo " "
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
                echo "This will delete all .txt files in this directory"
                read -r -e -p "Is this safe/okay? [y or n]: " dlt_ans
                if [[ "$dlt_ans" = "y" ]]; then
                  delete_Tests
                elif [[ "$dlt_ans" = "n" ]]; then
                  return
                fi
                ;;
        "Quit")
                echo "QUITING, take care!"
                break
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
          next_Search
          ;;
      "Print the File")
          print_Content
          ;;
      "Manipulate the File")
          PS3='What option? '
          options=("Get Unique IPs" "Delete .txt Files")
          select opt in "${options[@]}" "Back";
          do
            case $opt in
              "Get Unique IPs")
                get_ip
                print_IP_Content
                next_Step
                return
                ;;
              "Delete .txt Files")
                delete_Tests
                return
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
          echo "QUITING, take care!"
          exit
          ;;
      *)
          echo "Invalid option. Try another one."
          continue
          ;;
    esac
  done
}
## Main
set_Path () {
    printf "Please type your full file path, starting with a backslash if its absolute. "
    read -r -e -p "Its more than likely equal to $PWD/log.test: " inputPath
    if [ -z "$inputPath" ] & [ -f "$inputPath" ]
    then
      read -r -e -p "Path has been set to $inputPath, is this correct? [y or n]: " ans
      if [ "$ans" = "y" ]
      then
        what_Find
      else
        set_Path
      fi
    else
      echo "Please choose a valid path."
      set_Path
    fi
}
# this function collects the variable that is used to search the specified file and stores it as Look_for
what_Find () {
    print_line
    echo -n "What information would you like to find? (Do not use a Space if asking for a name.) "
    read -r Look_for
#    Look_for2=$(echo -e "${Look_for}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    Look_for_clean=$(echo -e "${Look_for}" | sed 's/[^a-zA-Z0-9]//g' | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    echo "Looking for $Look_for... Please wait... Search started at:" && date -u
    grep_Append
}
grep_Append () {
# I dont know why this works, how or if it even should.  This while statement
# shows my naivety to bash scripting though.
# DO NOT TOUCH!!!! THIS SHOULDNT WORK, SO THEREFORE ITS PERFECTLY BROKEN AS IS!
while :
   do
     grep -i "$Look_for_clean" "$inputPath" >> "$Look_for_clean.txt" || echo "$Look_for_clean not found. Try something else."
     if [ -f "./$Look_for_clean.txt" ]; then
       echo "$Look_for found and writing to file, check current directory for $Look_for.txt"
       echo "Search ended at " "$(date -u)"
       next_Step
     else
       delete_Miss
       echo "ERROR. Try a new Search"
       what_Find
     fi
   done
}
## File Manipulation
delete_Tests () {
    rm "./*.txt"
    echo "Files deleted. Take care."
}
delete_Miss () {
    rm "./$Look_for_clean.txt"
}
get_ip () {
    echo "Check the current directory for a file name IPs-$Look_for_clean.ips"
    awk '{print $1}' "$PWD/$Look_for_clean.txt" | uniq -u > "IPs-$Look_for_clean.ips"
}
print_Content () {
    print_line
    print_File
    next_Step
}
print_File () {
    FILE="$Look_for_clean.txt"
    cat "$FILE"
}
print_IP_Content () {
    FILE="IPs-$Look_for_clean.ips"
    echo "Below is the head print out of your new file."
    print_line
    head "$FILE"
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
Opening_Menu
