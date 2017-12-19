#!/usr/bin/env bash
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    set_default_applications_in_unity_launcher
#%
#% DESCRIPTION
#%    This script sets the unity launcher to only show:
#%    * nautilus-home
#%    * firefox
#%    * libreoffice-writer
#%    * libreoffice-calc
#%    * libreoffice-impress
#%
#================================================================
#- IMPLEMENTATION
#-    version         set_default_applications_in_unity_launcher (magenta.dk) 0.0.2
#-    author          Danni Als
#-    copyright       Copyright 2017, Magenta Aps"
#-    license         GNU General Public License
#-    email           danni@magenta.dk
#-
#================================================================
#  HISTORY
#     2017/22/11 : danni : Script creation
#     2017/23/11 : danni : User Unity Launcher should not contain amazon, ubuntu software and security copy.
#
#================================================================
# END_OF_HEADER
#================================================================
# Løsning fundet her:
# https://askubuntu.com/questions/611162/how-do-you-add-remove-applications-to-from-the-unity-launcher-from-command-line

set -e

AS_USER=user

USER_LOGGED_IN=$(who | cut -f 1 -d ' ' | sort | uniq | grep $AS_USER)

if [ $USER_LOGGED_IN ]
then
    # Run gsettings with X, change background right away.
    export DISPLAY=:0.0
    export XAUTHORITY=/home/$AS_USER/.Xauthority
    su - $AS_USER -s /bin/bash -c '/usr/bin/gsettings set com.canonical.Unity.Launcher favorites '\"'['\''application://nautilus-home.desktop'\'', '\''application://firefox.desktop'\'', '\''application://google-chrome.desktop'\'', '\''application://libreoffice-writer.desktop'\'', '\''application://libreoffice-calc.desktop'\'', '\''application://libreoffice-impress.desktop'\'', '\''unity://running-apps'\'', '\''unity://expo-icon'\'', '\''unity://devices'\'']'\"''
else
    su - $AS_USER -s /bin/bash -c 'dbus-launch --exit-with-session /usr/bin/gsettings set com.canonical.Unity.Launcher favorites '\"'['\''application://nautilus-home.desktop'\'', '\''application://firefox.desktop'\'', '\''application://google-chrome.desktop'\'', '\''application://libreoffice-writer.desktop'\'', '\''application://libreoffice-calc.desktop'\'', '\''application://libreoffice-impress.desktop'\'', '\''unity://running-apps'\'', '\''unity://expo-icon'\'', '\''unity://devices'\'']'\"''
fi


HIDDEN_DIR=/home/.skjult
cp /home/user/.config/dconf/$AS_USER $HIDDEN_DIR/.config/dconf/