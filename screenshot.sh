#!/bin/bash
# linux deps: xsel espeak scrot rsync
# osx deps: none
# assumptions: authorized to ssh into host w/o password
 
OS=`uname`
 
# Remote server to upload to
HOST="yourhost.com"
 
# Remote user to login to HOST with
USER="user"
 
# Path on remote server to upload to
UPLOAD_PATH="/path/to/www-img"
 
# Base path where image will be accessible from
BASE_URL="http://yourhost.com/img"
 
# Temp file to store screen shot
TEMP_FILE="$(mktemp /tmp/screenshot.XXXXX.png)"
 
# Take screen shot, save to temp file
if [[ "$OS" == "Linux" ]]; then
    scrot -s $TEMP_FILE
else
    screencapture -s $TEMP_FILE
fi
 
# Houston, we have a problem!
if [[ $? -ne 0 ]]; then
    if [[ "$OS" == "Linux" ]]; then
        espeak error &>/dev/null &
    else
        say error &
    fi
    exit 1
fi
 
# Create filename based on MD5 to guarantee uniqueness
if [[ "$OS" == "Linux" ]]; then
    MD5="$(cat $TEMP_FILE | md5sum)"
else
    MD5="$(cat $TEMP_FILE | md5)"
fi
 
# Only take first five characters from MD5
IMAGE_NAME="${MD5:0:5}.png"
 
# Copy file to remote server
rsync --chmod=u=rw,g=r,o=r --perms $TEMP_FILE $USER@$HOST:$UPLOAD_PATH/$IMAGE_NAME
 
# Copy link to clipboard
if [[ "$OS" == "Linux" ]]; then
    echo "$BASE_URL/$IMAGE_NAME" | tr -d '\n' | xsel --clipboard --input
else
    echo "$BASE_URL/$IMAGE_NAME" | tr -d '\n' | pbcopy
fi
 
# Cleanup
rm $TEMP_FILE
 
if [[ "$OS" == "Linux" ]]; then
    espeak ding &>/dev/null &
else
    say ding &
fi
