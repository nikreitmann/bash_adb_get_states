#!/bin/bash

## Config

# OpenHAB IP
openhabip=192.168.1.167

# Android Device IP
androidip=192.168.1.254

## Config END

if adb devices | grep $androidip;

then

   adb -s $androidip:5555 shell input keyevent 26

else

   adb connect $androidip:5555
   adb -s $androidip:5555 shell input keyevent 26

fi
