## Hello

(do)The main goal of this program was to get an A in my Linux class(done).  Secondary objective is to make a useful 
program foundation for use in data management and research.  In it's current rendition, it will parse a text file for a keyword, constantly until the program fails to find another iteration of said keyword, (ignoring line delimiters,) and will append the row contents to a new text file.  I believe collaborating is the key to any successful project and would be very interested to hear how running this program went for you. Would you add something? Do you see any opportunity for improvement? Did you hate it, or would you maybe recommend this to a friend? Let me know!

## Possible Use Cases

* analyzing server logs for suspect ip entries
* pulling all post requests out of server logs
* has been tested on apache2 and nginx access logs(works for ip's and for requests, probably more if you want it)
* Have a suggestion? Please let me know

Enter as many numbers from the IP that you can example;
192.168.1
this will pull the entire line, for every instance that is related to that ip, 
and print/append the data to a new file with the name of the search issued.

## Usage

* `git clone https://github.com/incredincomp/greprow/`
* `cd greprow`
* `sudo chmod +x greprow.sh`
* `./greprow {option -not needed}`

## DEV NOTE

When you exit the script, its going to ask you if you want to delete all the .txt files that you created so that you will be left with a clean directory(greprow works out of its own directoy structure.)
It is recommended that if you end up collecting any information that you would like to keep, either exit the script with `ctrl + c` or open a new terminal window and rename the file extensions to anything that `rm *.txt` wont delete, or move the files that you would like to keep for your records to a directory outside of `/greprow`.

## Proposed Changes

*  Set up options for specific types of log files to point to new functions for result file clean up
*  Some options I would like to add would be to add the ability to awk or sed only the IP's matching the pattern instead of entire line if you would like to make a target list or something like that from nmap results/or fire scans back at suspect IP's
*

### Warning

By nature, I break things that work well.  Just how it goes for me. That being said, I can make no certain prediction on how this code will react with a file, though it has not resulted in the loss of data for me during testing, if you use this outside of the scope of testing in a production environment, I should not be held responsible for your neglect to heed my warning.. Have fun!

### Support or Contact

Email me at incredincomp@gmail.com if you have any recommendations or issues. Thanks for your help!


