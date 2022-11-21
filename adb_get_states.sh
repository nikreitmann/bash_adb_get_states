#!/bin/bash

## Config

# OpenHAB IP
openhabip=192.168.1.167

# OpenHAB Item current app
openhabitem_current_app=android_schlafzimmer_current_app

# OpenHAB Item playstate
openhabitem_playstate=android_schlafzimmer_playstate

# OpenHAB Item Power
openhabitem_power=android_schlafzimmer_power

# Android Device IP
androidip=192.168.1.254

## Config END

if adb devices | grep $androidip;

then

   CRAPP=$(adb -s $androidip:5555 shell dumpsys activity recents | grep 'Recent #0' | cut -d":" -f 3 | cut -d" " -f 1)
   CPLAY=$(adb -s $androidip:5555 shell dumpsys audio | grep AudioPlaybackConfiguration | grep type:android.media.AudioTrack | cut -d " " -f7 | cut -d ":" -f2)
   PWR=$(adb -s $androidip:5555 shell dumpsys power | grep mWakefulness= | cut -d"=" -f2)
   curl http://$openhabip:8080/basicui/CMD?$openhabitem_current_app=$CRAPP
   curl http://$openhabip:8080/basicui/CMD?$openhabitem_playstate=$CPLAY
   curl http://$openhabip:8080/basicui/CMD?$openhabitem_power=$PWR
   echo "current app: $CRAPP"
   echo "playstate is: $CPLAY"
   echo "powerstate is: $PWR"

else

   adb connect $androidip:5555
   CRAPP=$(adb -s $androidip:5555 shell dumpsys activity recents | grep 'Recent #0' | cut -d":" -f 3 | cut -d" " -f 1)
   CPLAY=$(adb -s $androidip:5555 shell dumpsys audio | grep AudioPlaybackConfiguration | grep type:android.media.AudioTrack | cut -d " " -f7 | cut -d ":" -f2)
   PWR=$(adb -s $androidip:5555 shell dumpsys power | grep mWakefulness= | cut -d"=" -f2)
   curl http://$openhabip:8080/basicui/CMD?$openhabitem_current_app=$CRAPP
   curl http://$openhabip:8080/basicui/CMD?$openhabitem_playstate=$CPLAY
   curl http://$openhabip:8080/basicui/CMD?$openhabitem_power=$PWR
   echo "current app: $CRAPP"
   echo "playstate is: $CPLAY"
   echo "powerstate is: $PWR"

fi
