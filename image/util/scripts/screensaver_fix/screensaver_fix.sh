#!/usr/bin/env bash

# Manual fix for OS2borgerPC 1.5
# Completely turn off screensaver, including BIOS power saving.


XSESSION_TMP=/tmp/xsession_${RANDOM}
OS2BORGERPC_INSTALL_DIR=/home/.skjult
TARGET_FILE=${OS2BORGERPC_INSTALL_DIR}/.xsessionrc

cat << EOF > $XSESSION_TMP
#!/usr/bin/env bash

xset s off
xset -dpms

EOF

if [[ -d $OS2BORGERPC_INSTALL_DIR ]]
then 
    gksudo mv $XSESSION_TMP $TARGET_FILE && chmod a+x $TARGET_FILE
    # Check if successful or not
    if [[ ! -z $(grep dpms $TARGET_FILE) ]]
    then
        zenity --info --text "Opdateringen er installeret!"
    else 
        zenity --info --text "Opdateringen mislykkedes - check password"
    fi
else 
    zenity --warning --text "Dette er ikke en OS2borgerPC-maskine"
fi


