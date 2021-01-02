#!/bin/sh
touchpad=$(xinput list | grep HAILUCK | grep Touchpad | egrep -o 'id=[0-9]+' | egrep -o '[0-9]*')
prop=$(xinput --list-props $touchpad | grep 'Accel Speed' | head -1 | awk '{print $4}' | tr -d '():')
xinput --set-prop $touchpad $prop 0.7
