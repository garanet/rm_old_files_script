#!/bin/bash
# www.garanet.net
# If you need to remove files periodically, you can make a cronjob with an easy bash script like this one.
# https://github.com/garanet/rm_old_files_script

# SET YOUR VARIABLES
path=
email=
tmp=/tmp/rm_old_files_log.tmp
filename=/tmp/rm_old_files_log.lock

# SET LOCK FILE
if [ -e /tmp/$filename ]
        then
        echo Lock found, suiciding...Already running !
        exit 0;
fi
# MAKE THE LOCK
touch $filename

# RUN THE COMMAND Deleting files in $path, older more 2 days .
find $path -type f -mtime +2 -exec rm {} >> $tmp \;

# SEND EMAIL, REMOVE TMP AND LOCK FILES
mail -s "Removed old files on $path " $email < $tmp
rm $tmp
rm $filename
#END
