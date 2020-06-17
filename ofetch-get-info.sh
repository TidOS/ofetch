#!/bin/bash


case $1 in
MACOS)
    # MacOS version
    sw_vers | awk -F "\:\t" '{printf "%s",$2}'
    echo
    ;;
CPU)
    # CPU
    sysctl -n machdep.cpu.brand_string
    ;;
RAM)
    # RAM in MB
    sysctl -n hw.memsize|awk '{printf("%d", $1/1e+06)}'
    ;;
MODEL)
    # Mac model
    sysctl -n hw.model
    ;;
GPU)
    # Video card
    system_profiler SPDisplaysDataType|awk -F"\:\ " '/Chipset|VRAM/{printf "%s ",$2}'
    echo
    ;;

THERM)
    # temperature in C - fails on hackintosh
    sudo powermetrics --samplers smc -i1 -n1 | grep -i "CPU die" | awk '{printf("%s °C",$4)}'
    echo
    ;;

DISK)
    # rootfs disk usage
    df -h / | tail -n 1 | sed 's/Gi//g' | awk '{printf("%s/%s GiB free\n",$4,$2)}'
    ;;
    
KERNEL)
    #kernel
    uname -rms
    ;;
    
SHELL)
    #shell
    echo "zsh"
    ;;
    
TERM)
    #terminal
    echo $TERM
    ;;
    
BREW)
    #package count from brew
    brew list | wc -l | awk {'printf("%s packages", $1)'}
    ;;
    
*)
    echo DUMMY
    ;;
esac
