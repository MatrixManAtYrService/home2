#!/bin/sh

# https://askubuntu.com/questions/1038490/how-do-you-set-a-default-audio-output-device-in-ubuntu-18-04
pactl set-default-sink alsa_output.pci-0000_0b_00.3.iec958-stereo
pactl set-default-source alsa_input.usb-Focusrite_Scarlett_Solo_USB_Y7NNRU30597676-00.analog-stereo

