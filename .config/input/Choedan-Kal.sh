#!/bin/sh
touchpad=$(xinput list | grep HAILUCK | grep Touchpad | egrep -o 'id=[0-9]+' | egrep -o '[0-9]*')
xinput --set-prop $touchpad 297 0.7
