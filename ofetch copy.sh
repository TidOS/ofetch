#!/usr/bin/env python3
import os
from os import system
import blessings
from blessings import Terminal
import tempfile

system('reset')

#rainbow style
logo_colors=[10,10,10,11,11,3,3,9,9,8,8,12,12,12,5]

#gray
#logo_colors=[7,7,7,7,7,7,7,7,7,7,7,7,7,7,7]


logo_lines=["                :++++.         ",
"               /+++/.          ",
"       .:-::- .+/:-\`\`.::-    ",
"    .:/++++++/::::/++++++/:\`  ",
"  .:///////////////////////:\` ",
"  ////////////////////////\`   ",
" -+++++++++++++++++++++++\`    ",
" /++++++++++++++++++++++/      ",
" /sssssssssssssssssssssss.     ",
" :ssssssssssssssssssssssss-    ",
"  osssssssssssssssssssssssso/\\",
"  \`syyyyyyyyyyyyyyyyyyyyyyyy+\\",
"   \`ossssssssssssssssssssss/   ",
"     :ooooooooooooooooooo+.    ",
"      \`:+oo+/:-..-:/+o+/-   "]
term = Terminal()

infos = ["SYSTEM", "CPU"]

tempfile = tempfile.NamedTemporaryFile(mode = 'w')
readfile = open(tempfile.name)
# system
system("uname -rms > " + tempfile.name)
SYSTEM=term.bold("SYSTEM: " + term.green + readfile.readline() + term.normal)
#cpu
system("sysctl -n machdep.cpu.brand_string > " + tempfile.name)
CPU=term.bold("CPU:    " + term.green + readfile.readline() + term.normal)
#ram
system("sysctl -n hw.memsize | awk \'{printf(\"%d\", $1/1e+06)}\' > " + tempfile.name)
RAM=term.bold("RAM:   " + term.green + readfile.readline() + " " + term.green + "MiB" + term.normal)

logo_width=0
line=0
for i in logo_lines:
#    print(str(line) + ": " + term.color(logo_colors[line]) + i + term.normal)
    print(term.color(logo_colors[line]) + i + term.normal)
    line = line + 1
    if len(i) > logo_width:
        logo_width=len(i)
XText = logo_width + 3

with term.location(XText,y=0):
    print(SYSTEM)
with term.location(XText,y=1):
    print(CPU)
with term.location(XText, y=2):
    print(RAM)

tempfile.close()
readfile.close()

#os.execvp('imgcat', ["1","./small.png"])


